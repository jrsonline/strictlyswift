//
//  HKTlib.swift
//  HKT
//
//  Created by JonLily on 1/23/18.
//  Copyright © 2018 jsoft-online. All rights reserved.
//

import Foundation

/// Lift a type T<A> to its TypeConstructor representation Construct<T,A>
postfix operator ^

/// Lower a constructor Construct<T,A> to its original type T<A>, in continuation-passing style
infix operator >>>¬ : LogicalConjunctionPrecedence
postfix operator ¬


// This example shows how higher-kinded types can be emulated in Swift today.
// It acheives correct typing at the cost of some boilerplate, manual lifting and an existential representation.
// The technique below was directly inspired by the paper Lightweight Higher-Kinded Polymorphism
// by Jeremy Yallop and Leo White found at http://ocamllabs.io/higher/lightweight-higher-kinded-polymorphism.pdf

public protocol Constructible {
    associatedtype TypeParameter
}

public protocol HKTTag {
    associatedtype ActualType
}

/// `ConstructorTag` represents a type constructor.
/// `TypeParameter` represents an argument to the type constructor.
public struct Construct<ConstructorTag : HKTTag, TypeParameter>  {
    /// An existential containing a value of `Constructor<TypeParameter>`
    /// Where `Constructor` is the type constructor represented by `ConstructorTag`
    let tag: ConstructorTag
    
}

/// A protocol all type constructors must conform to.
public protocol _TypeConstructor {
    /// The existential type that erases `TypeParameter`.
    /// This should only be initializable with values of types created by the current constructor.
    associatedtype Tag where Tag : HKTTag
    /// The argument that is currently applied to the type constructor in `Self`.
    associatedtype TypeParameter
    
    /// `self` stored in the Tag existential
    var lift: Construct<Tag, TypeParameter> { get }
    /// Must unwrap the `app.tag` existential.
    static func lower(_ con: Construct<Tag, TypeParameter>) -> Self
}


/// Lift a type to a type constructor with associated tag
public postfix func ^<T>(t: T) -> Construct<T.Tag, T.TypeParameter> where T: _TypeConstructor {
    return t.lift
}

// curry function
/// Convert a function like f(a,b) -> c into  f(a) -> (b) -> c
public func curry<A,B,C>(_ f:@escaping (A,B) -> C) -> (A) -> (B) -> C {
    return { a in {b in f(a,b) }}
}

/// Convert a function like f(a,b,c) -> d into  f(a) -> (b) -> (c) -> d
public func curry<A,B,C,D>(_ f:@escaping (A,B,C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in {b in {c in f(a,b,c) }}}
}

