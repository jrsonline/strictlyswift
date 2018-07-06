//
//  main.swift
//  FunctorProject
//
//  Created by @strictlyswift on 1/31/18.
//

import Foundation

// First let's set up a couple of different collections
let linkedList = LinkedList.start(2).addToStart(3).addToEnd(4)
let regularArray = [3,2,4]

// Next, define some functions
let isOdd = {$0 % 2 == 1}
let stringIt = { $0 ? "yes" : "no" }

// We have made LinkedList and Array conform to Functor so we can now fmap them
let oddsA1 =   linkedList.fmap(isOdd).fmap(stringIt)
let oddsA2 = regularArray.fmap(isOdd).fmap(stringIt)

print(oddsA1)
print(oddsA2)


// Applicatives

// Calculate retirement fund. Note, no WebData here.
func calcAnnualRetirementFund( ageNow: Int,
                               ageRetire: Int,
                               savings: Double ) -> Double {
        return savings/Double(ageRetire-ageNow)
}

// Suppose we get data from the Web.
// It's tainted by default:
let ageFromWeb = WebData.taint(40)
let retirementAge = WebData.taint(65)
let savingsToRetire = WebData.taint(100000.00)

// Appl3 applies a 3-parameter function
// across 3 items in  [ ... ]
let result = Appl3(calcAnnualRetirementFund)[ ageFromWeb, retirementAge, savingsToRetire ]
// result is WebData.tainted(4000.0)

// Now, let's clean the data:
let cleanedAge = ageFromWeb.clean()
let cleanedRetirementAge = retirementAge.clean()
let cleanedSavings = savingsToRetire.clean()

// So result2 is WebData.safe(4000.0)
let result2 = Appl3(calcAnnualRetirementFund)[ cleanedAge, cleanedRetirementAge, cleanedSavings ]

// Continuation-passing style
let result3 = curry(calcAnnualRetirementFund)
    <¢> cleanedAge^
    <*> cleanedRetirementAge^
    <*> cleanedSavings^
    >>>¬ toWebData
//  result3 is WebData.safe(4000.0)


// data coming in is tainted by default
let firstNameFromWeb = WebData("Bob")
let lastNameFromWeb = WebData("Jones")



func makeFullName( first:String, last:String ) -> String {
    return "Hello, "+first+" "+last+"!"
}



func capitalize(s: String) -> String {
    return s.uppercased()
}


print( firstNameFromWeb.fmap(capitalize) )

// Note that in these examples, the data stays TAINTED
// First, using fully generic, multi-argument, ApplicativeTag version
print( curry(makeFullName) <¢> firstNameFromWeb^ <*> lastNameFromWeb^ >>>¬ toWebData )

// WebData specific version
print( Appl2(makeFullName)[ firstNameFromWeb, lastNameFromWeb ] )

// closure version - shows how lightweight the application becomes
let resultL: WebData = Appl2{ "Hello, "+$0+" "+$1+"!" }[ firstNameFromWeb, lastNameFromWeb ]
print( resultL )




// Now we clean the data; the same set of functions
// now returns the cleaned response
let cleanedFirstName = firstNameFromWeb.clean()
let cleanedLastName = lastNameFromWeb.clean()

print( Appl2(makeFullName)[ cleanedFirstName, cleanedLastName ] )

// With cleaned data:
let resultC = Appl3(calcAnnualRetirementFund)[ cleanedAge,
                                               cleanedRetirementAge, cleanedSavings ]
// result WebData.safe(4000.0)

// But if we try and mix clean and tainted data, we get tainted !
print( "Must save each year: $",Appl3(calcAnnualRetirementFund)[ cleanedAge, cleanedRetirementAge, savingsToRetire ] )


// By way of comparison, let's try and write the calcAnnualRetirementFund without the applicative
// first we note we need to make it WebData specific -- no more re-usable function
func calcAnnualRetirementFund2( ageNow: WebData<Int>,
                                ageRetire: WebData<Int>,
                                savings: WebData<Double> )
    -> WebData<Double> {
        switch (ageNow, ageRetire, savings) {
        // Note I can't do a default as I need to unwrap the n,r,s values
        case let (.safe(n), .safe(r), .safe(s)): return .safe(s/Double(r-n))
        case let (.safe(n), .safe(r), .taint(s)): return .taint(s/Double(r-n))
        case let (.safe(n), .taint(r), .safe(s)): return .taint(s/Double(r-n))
        case let (.safe(n), .taint(r), .taint(s)): return .taint(s/Double(r-n))
        case let (.taint(n), .safe(r), .safe(s)): return .taint(s/Double(r-n))
        case let (.taint(n), .safe(r), .taint(s)): return .taint(s/Double(r-n))
        case let (.taint(n), .taint(r), .safe(s)): return .taint(s/Double(r-n))
        case let (.taint(n), .taint(r), .taint(s)): return .taint(s/Double(r-n))
        }
}


// Can also use ApplReduce to apply a 'reducing function' like +


// Optional as an applicative functor
let val1 = Int("123")
let val2 = Int("3;45")
let val3 = Int("456")

// Any function with a nil will fail to nil
print( ApplReduce(+)[val1, val2, val3] ?? "nil" )  // "nil"
print( ApplReduce(+)[val1, 345, val3] ?? "nil" )  // 924

print( ApplReduce(+)[firstNameFromWeb, WebData(" "), lastNameFromWeb] )

print( ApplReduce(+)[WebData(1), WebData(2), WebData(3)] ) // WebData(6)



// Array returns all of the combinations
print( ApplReduce(*)[ [1,2], [3,4] ] )
// [3,4,6,8] = [ 1*3, 1*4, 2*3, 2*4 ]
print( ApplReduce(*)[ [1,2], [3,4], [5,6] ] )
// [15, 18, 20, 24, 30, 36, 40, 48] = [1*3*5, 1*3*6, 1*4*5, 1*4*6...]

// Alternatively we can use ZipArray which zips the combinations together
print( ApplReduce(*)[ ZipArray(1,2), ZipArray(3,4) ] )
// [3,8] = [1*3, 2*4]
print( ApplReduce(*)[ ZipArray(1,2), ZipArray(3,4), ZipArray(5,6) ] )
// [15,48] = [1*3*5, 2*4*6]

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Monad Magic

// Let's say we get some input from the web
let emailInput = WebData("bjones@email.com", withValidator: emailValidator)
let dodgyEmailInput = WebData("fak3N@m3", withValidator: emailValidator)

// and we want to greet the user...
let greeter: (String) -> WebData<String> = { return WebData.safe("Hi \($0)!") }

// We need to be careful when we greet someone though - "greeter" turns every input into a 'safe' input
// let's keep it tainted if it was tainted initially:
func greetSafely(_ name: WebData<String> ) -> WebData<String> {
    switch name {
    case .safe(let n): return greeter(n)
    case .taint(let n): return greeter(n).taint()
    }
}

print( greetSafely( emailInput ) )
print( greetSafely( dodgyEmailInput ) )

// How about a more generic version that's not tied to greeter? That would look like this:
extension WebData {
    func applySafely<B>(_ trans: @escaping (A) -> WebData<B> ) -> WebData<B> {
        switch self {
        case .taint(let a): return trans(a).taint()
        case .safe(let a): return trans(a)
        }
    }
}

// So if we have a way of finding the name of a user from their email:
// func findUserName(_ withEmail:String) ->  WebData<String> 

// Let's try that:
print( emailInput.applySafely(findUserName).applySafely(greeter) )
print( dodgyEmailInput.applySafely(findUserName).applySafely(greeter) )


// WebData also defines an operator >>>= called "bind"
// which basically just calls "applySafely" on its right-hand argument
// Now we can chain these nicely!
print (emailInput >>>= findUserName >>>= greeter)
print (dodgyEmailInput >>>= findUserName >>>= greeter)


// Therefore WebData is a Monad... it defines "bind" , and also "pure" (see the WebData.swift file)

// Optional is a Monad too, and we define "bind" and "pure" for it (see ArrayOptionalFunctor.swift)

// Suppose we have a list of Strings, possibly representing numbers, and we want to check if the first value in the list is even.
// If the list is empty, or if the first value is not an even number, then return nil.

let list : [String] = ["1.5", "1", "2.5", "2"]

// A couple of helper functions:
let firstValue : ([String]) -> String? = { $0.first }
let toInt : (String) -> Int? = { Int($0) }
let isEven : (Int) -> String? = { ($0 % 2 == 0) ? "even" : nil }

// Thanks to the Monad bindings, calculating the result is now very straightforward, with no optional unwrapping!
let firstValueIsEven = list >>>= firstValue >>>= toInt >>>= isEven

// How would we do that WITHOUT the monad binding?  Pretty nasty with the var !
var firstValueIsEven2 : String? = nil
if let first = firstValue(list), let asInt = toInt(first) {
    firstValueIsEven2 = isEven(asInt)
}


// Arrays are monads too... "bind" is EXACTLY flatMap
// In fact you could say monads are "flattenable" (flatmappable)

// Suppose we are running a chess tournament in 3 different cities. We want to produce the roster of all the different games,
// where every competitor must play everyone else.

// Let's try this using regular array functions:
func matchupsForCities(cities:[String]) -> [Matchup] {
    var matchups = [Matchup]()
    for city in cities {
        let teamA = teamForCity(city, Team.A)
        let teamB = teamForCity(city, Team.B)
        for p1 in teamA {
            for p2 in teamB {
                matchups += [Matchup(city:city,
                                     player1:p1,
                                     player2:p2)]
            }
        }
    }
    return matchups
}

// Using bind  (remember -- it's really flatMap!) makes this much easier to read:
func matchupsForCities2(cities:[String]) -> [Matchup] {
    return cities >>>= { city in
           teamForCity(city, Team.A) >>>= { p1 in
           teamForCity(city, Team.B) >>>= { p2 in
           [Matchup(city:city, player1:p1, player2:p2)]
	}}}
}
