//
//  Functor.swift
//  HKT
//
//  Created by @strictlyswift on 1/23/18.
//

import Foundation
infix operator >>>• : MultiplicationPrecedence

//a "tag" protocol, used by Sourcery
public protocol Functor  { }

public protocol FunctorTag : HKTTag {
    typealias F = Self
    static func fmap<A,B>(_ transform: @escaping (A) -> B ) -> (Construct<F,A>) -> Construct<F,B>
}


// fmap
extension Construct where ConstructorTag : FunctorTag {
    public func fmap<B>(_ transform: @escaping (TypeParameter) -> B ) -> Construct<ConstructorTag,B>
    {
        return ConstructorTag.fmap(transform)(self)
    }
}


