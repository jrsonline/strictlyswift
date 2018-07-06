//
//  helpers.swift
//  FunctorProject
//
//  Created by @strictlyswift on 7/5/18.
//

import Foundation

extension String {
    func matchesRE(_ regex: String, options: NSRegularExpression.Options = [] ) -> Bool? {
        guard let re = try? NSRegularExpression(pattern: regex, options: options) else { return nil }
        return (re.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count ))?.range(at: 0).length ?? 0) > 0
    }
}

let lettersOnlyValidator : (String) -> Bool = { return ($0.rangeOfCharacter(from: CharacterSet.letters.inverted )) == nil }
let emailValidator : (String) -> Bool = { return ($0.matchesRE("[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.[a-zA-Z0-9]+") ?? false) }

func findUserName(_ withEmail:String) ->  WebData<String> {
    switch withEmail {
    case "bjones@email.com":
        return .safe("Bob Jones")
    default:
        return .taint("unknown")
    }
}


let cities = ["Newcastle", "Manchester", "Liverpool"]
let teamAForCity = [ "Newcastle" : ["Sarah","George","Xu"], "Manchester" : ["Carlos","Alex","Claire"], "Liverpool" : ["Brad","Sujith"]]
let teamBForCity = [ "Newcastle" : ["Peter","Petra"], "Manchester" : ["Carla","Craig"], "Liverpool" : ["Richard","Rachel","Raquel"]]

struct Matchup { let city, player1, player2 : String }

enum Team {
    case A
    case B
    func sideFor(_ city: String) -> [String] {
        switch self {
        case .A: return teamAForCity[city] ?? []
        case .B: return teamBForCity[city] ?? []
        }
    }
}

func teamForCity(_ city:String, _ team: Team) -> [String] {
    return team.sideFor(city)
}
