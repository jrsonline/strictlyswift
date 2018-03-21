//
//  Conformance
//  HKT
//
//  Created by JonLily on 1/23/18.
//  Copyright © 2018 jsoft-online. All rights reserved.
//

import Foundation

extension Array : Constructible {
    public typealias TypeParameter = Element
}

extension Optional : Constructible {
    public typealias TypeParameter = Wrapped
}


extension Array : Applicative {
    public static func pure<A>(_ a: A) -> [A] {
        return [a]
    }
    
    public func ap<B>(_ fAB: Array<(Element) -> B>) -> Array<B> {
        return fAB.flatMap {
            f in self.map { a in f(a) } }
    }
}


extension Optional : Applicative {
    public static func pure<A>(_ a: A) -> A? {
        return (a as A?)
    }
    
    public func ap<B>(_ fAB: Optional<(Wrapped) -> B>) -> Optional<B> {
        switch (self, fAB) {
        case (.some(let a), .some(let f)): return f(a)
        default: return (nil as B?)
        }
    }
}


// No need to have conformances to Functor or FunctorTag (or ApplicativeTag)
// Sourcery creates them for us


