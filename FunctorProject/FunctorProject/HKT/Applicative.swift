//
//  Applicative.swift
//  HKT
//
//  Created by @strictlyswift on 1/23/18.
//

import Foundation

/* original applicative paper: http://www.staff.city.ac.uk/~ross/papers/Applicative.pdf */
// key observation: " Lifting multi-argument functions into a Functor is a very natural thing to do"
// ... that is what Applicative does.

infix operator <*> : AdditionPrecedence
infix operator <¢> : MultiplicationPrecedence

protocol ApplicativeTag : HKTTag {
    typealias F = Self
    
    static func pure<A>(_ a: A) -> Construct<F,A>
    static func ap<A,B>(_ fAB: Construct<F, (A)->B> ) -> (Construct<F,A>) -> Construct<F,B>
}


protocol Applicative { }


struct Appl1<A,B> {
    let f1: (A) -> B
    
    init(_ f1: @escaping (A) -> B) {
        self.f1 = f1
    }
    func to<F>(_ first: Construct<F,A>) -> Construct<F,B>
        where F : ApplicativeTag
    {
        return appl( f: f1, to: first )
    }

}
struct Appl2<A,B,C> {
    let f2: (A,B) -> C
    
    init( _ f2: @escaping (A,B) -> C) {
        self.f2 = f2
    }
    func to<F>(_ first: Construct<F,A>, _ second: Construct<F,B> ) -> Construct<F,C>
        where F : ApplicativeTag
    {
        return appl( f: f2, to: first, second )
    }
}

struct Appl3<A,B,C,D> {
    let f3: (A,B,C) -> D
    
    init(_ f3: @escaping (A,B,C) -> D) {
        self.f3 = f3
    }
    func to<F>(_ first: Construct<F,A>, _ second: Construct<F,B>, _ third: Construct<F,C>  ) -> Construct<F,D>
    where F : ApplicativeTag
    {
        return appl( f: f3, to: first, second, third )
    }
}

struct Appl4<A,B,C,D,E> {
    let f4: (A,B,C,D) -> E
    
    init(_ f4: @escaping (A,B,C,D) -> E) {
        self.f4 = f4
    }
    func to<F>(_ first: Construct<F,A>, _ second: Construct<F,B>, _ third: Construct<F,C> , _ fourth: Construct<F,D> ) -> Construct<F,E>
        where F : ApplicativeTag
    {
        return appl( f: f4, to: first, second, third, fourth )
    }
}

struct Appl5<A,B,C,D,E,F> {
    let f5: (A,B,C,D,E) -> F
    
    init(_ f5: @escaping (A,B,C,D,E) -> F) {
        self.f5 = f5
    }
    func to<T>(_ first: Construct<T,A>, _ second: Construct<T,B>, _ third: Construct<T,C> , _ fourth: Construct<T,D> , _ fifth: Construct<T,E>) -> Construct<T,F>
        where T : ApplicativeTag
    {
        return appl( f: f5, to: first, second, third, fourth, fifth )
    }
}

struct ApplReduce<Elt>  {
    let f: (Elt,Elt) -> Elt

    init(_ f: @escaping (Elt,Elt) -> Elt) {
        self.f = f
    }
    
    func to<F>(_ params: [Construct<F,Elt>]) -> Construct<F,Elt>
    where F : ApplicativeTag
    {
        return applreduce( f: f, to: params)
    }
}


func <*><P,Q,A>(f: Construct<A, (P) -> Q>, p: Construct<A, P>) -> Construct<A, Q>
    where A : ApplicativeTag
{
    return A.ap(f)(p)
}

func <¢><P,Q,A>(f: @escaping (P) -> Q, p: Construct<A,P>) -> Construct<A,Q>
    where A: ApplicativeTag
{
    return A.ap(A.pure(f))(p)
}

/// Single argument version of appl
func appl<A,P,Q>( f: @escaping (P) -> Q, to p:Construct<A,P> ) -> Construct<A,Q>
    where A : ApplicativeTag
{
    return f <¢> p
}

/// Curried version of appl, using a type-constructor-wrapped 2-parameter function
func appl<A,P,Q,R>( f: @escaping (P) -> (Q) -> R,  to p:Construct<A,P>, _ q:Construct<A,Q> ) -> Construct<A,R>
where A : ApplicativeTag
{
    
    return f <¢> p <*> q
}

/// Uncurried 2-argument version of appl, passing in a function without a type constructor
func appl<A,P,Q,R>( f: @escaping (P, Q) -> R, to p:Construct<A,P>, _ q:Construct<A,Q> ) -> Construct<A,R>
    where A : ApplicativeTag
{
    return appl( f: curry(f), to: p, q)
}

/// Curried version of appl, using a type-constructor-wrapped 3-parameter function
func appl<A,P,Q,R,S>( f: @escaping (P) -> (Q) -> (R) -> S, to p:Construct<A,P>, _ q:Construct<A,Q>, _ r:Construct<A,R>) -> Construct<A,S>
    where A : ApplicativeTag
{
    return f <¢> p <*> q <*> r
}

/// Uncurried 3-argument version of appl, passing in a function without a type constructor
func appl<A,P,Q,R,S>( f: @escaping (P, Q, R) -> S, to p:Construct<A,P>, _ q:Construct<A,Q>, _ r:Construct<A,R> ) -> Construct<A,S>
    where A : ApplicativeTag
{
    return appl( f: curry(f), to: p, q, r)
}

/// Curried version of appl, using a type-constructor-wrapped 4-parameter function
func appl<A,P,Q,R,S,T>( f: @escaping (P) -> (Q) -> (R) -> (S) -> T, to p:Construct<A,P>, _ q:Construct<A,Q>, _ r:Construct<A,R>, _ s:Construct<A,S>) -> Construct<A,T>
    where A : ApplicativeTag
{
    return f <¢> p <*> q <*> r <*> s
}

/// Uncurried 4-argument version of appl, passing in a function without a type constructor
func appl<A,P,Q,R,S,T>( f: @escaping (P, Q, R, S) -> T, to p:Construct<A,P>, _ q:Construct<A,Q>, _ r:Construct<A,R>, _ s:Construct<A,S> ) -> Construct<A,T>
    where A : ApplicativeTag
{
    return appl( f: curry(f), to: p, q, r, s)
}

/// Curried version of appl, using a type-constructor-wrapped 5-parameter function
func appl<A,P,Q,R,S,T,U>( f: @escaping (P) -> (Q) -> (R) -> (S) -> (T) -> U, to p:Construct<A,P>, _ q:Construct<A,Q>, _ r:Construct<A,R>, _ s:Construct<A,S>, _ t:Construct<A,T>) -> Construct<A,U>
    where A : ApplicativeTag
{
    return f <¢> p <*> q <*> r <*> s <*> t
}

/// Uncurried 5-argument version of appl, passing in a function without a type constructor
func appl<A,P,Q,R,S,T,U>( f: @escaping (P, Q, R, S, T) -> U, to p:Construct<A,P>, _ q:Construct<A,Q>, _ r:Construct<A,R>, _ s:Construct<A,S>, _ t:Construct<A,T> ) -> Construct<A,U>
    where A : ApplicativeTag
{
    return appl( f: curry(f), to: p, q, r, s, t)
}

/// applreduce takes it a bit differently, given a 'reducing function' f (Elt->Elt)->Elt, it
/// repeatedly applies f to each pair of parameters
func applreduce<A,Elt>( f: @escaping (Elt,Elt) -> Elt, to: [Construct<A,Elt>]) -> Construct<A,Elt>
    where A : ApplicativeTag
{
    guard to.count >= 2 else { fatalError("applreduce must be applied to >= 2 parameters") }

    let g = curry(f)

    var reduce = to[0]
    for n in 1 ..< to.count {
        reduce = g <¢> reduce <*> to[n]
    }
    return reduce
}


