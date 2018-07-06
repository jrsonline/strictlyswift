//
//  Monad.swift
//  HKT
//
//  Created by JonLily on 1/23/18.
//  Copyright © 2018 jsoft-online. All rights reserved.
//

import Foundation

precedencegroup FishGroup {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator >>>= : MultiplicationPrecedence
infix operator >=> : FishGroup

/// Monads provide a way to combine computations.
///
/// Given a Monad `M<A>` and a function `(A) -> M<B>`, a function `bind` should be defined as:
///
///     func bind<A,B>(_ m:M<A> ) -> ( @escaping (A) -> M<B>) -> M<B>
///
/// and a function `pure` (a "Monad-builder") should be defined as:
///
///     func pure<A>(_ value: A) -> M<A>
///
/// An operator `>>>=` will be defined automatically to allow monad chains to be built.
public protocol Monad {}

public protocol MonadTag: HKTTag {
    typealias M = Self
    static func pure<A>(_ value: A) -> Construct<M, A>
    static func bind<A,B>(_ m:Construct<M, A> ) -> ( @escaping (A) -> Construct<M, B>) -> Construct<M, B>
}



extension Construct where ConstructorTag:  MonadTag {
    static func bind<B>(_ m: Construct<ConstructorTag, TypeParameter>) -> (@escaping (TypeParameter) -> Construct<ConstructorTag, B>) -> Construct<ConstructorTag, B> {
        return { continuation in
            return ConstructorTag.bind(m)(continuation)
        }
    }
    
    static func pure<A>(_ value: A) -> Construct<ConstructorTag, A> {
        return ConstructorTag.pure(value)
    }
    
}

func >>>=<A,B,M>(left: Construct<M, A>, right: @escaping (A) -> Construct<M,B>) -> Construct<M,B>
    where M: MonadTag
{
    return M.bind(left)(right)
}



extension _TypeConstructor where Tag : MonadTag {
    static func wrap(_ value: TypeParameter) -> Construct<Tag, TypeParameter> {
        return Tag.pure(value)
    }
}


