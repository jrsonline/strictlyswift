//
//  HKTlib.swift
//  HKT
//
//  Created by @strictlyswift on 1/23/18.
//

import Foundation

/// Lift a type T<A> to its TypeConstructor representation Construct<T,A>
postfix operator ^

/// Lower a constructor Construct<T,A> to its original type T<A>, in continuation-passing style
infix operator >>>¬ : LogicalConjunctionPrecedence
postfix operator ¬

// This code adapted from an original by Matthew Johnson.
//
// This example shows how higher-kinded types can be emulated in Swift today.
// It acheives correct typing at the cost of some boilerplate, manual lifting and an existential representation.
// The technique below was directly inspired by the paper Lightweight Higher-Kinded Polymorphism
// by Jeremy Yallop and Leo White found at http://ocamllabs.io/higher/lightweight-higher-kinded-polymorphism.pdf

public protocol Constructible {
    associatedtype TypeParameter
}

public protocol DualConstructible {
    associatedtype TypeParameter
    associatedtype FixedType
}

public protocol HKTTag {
}

/// `ConstructorTag` represents a type constructor.
/// `TypeParameter` represents an argument to the type constructor.
public struct Construct<ConstructorTag : HKTTag, TypeParameter>  {
    /// An existential containing a value of `Constructor<TypeParameter>`
    /// Where `Constructor` is the type constructor represented by `ConstructorTag`
    let tag: ConstructorTag
    
}

public struct ConstructDual<ConstructorTag, FixedType, TypeParameter>  {
    /// An existential containing a value of `Constructor<FixedType,TypeParameter>`
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
    associatedtype ReturnType = Self
    
    /// `self` stored in the Tag existential
    var lift: Construct<Tag, TypeParameter> { get }
    /// Must unwrap the `app.tag` existential.
    static func lower(_ con: Construct<Tag, TypeParameter>) -> ReturnType
}

/// A protocol all type constructors must conform to.
public protocol _TypeConstructorDual {
    /// The existential type that erases `TypeParameter`.
    /// This should only be initializable with values of types created by the current constructor.
    associatedtype Tag where Tag : HKTTag
    /// The arguments that are currently applied to the type constructor in `Self`. See the note for FixedType
    /// for which type to use on a generic type with 2 type parameters.
    associatedtype TypeParameter
    associatedtype ReturnType = Self
    
    /// This is not "contained".  So with Writer<W,A> , W describes the 'Writer' and A is what Writer<W> contains.
    ///
    /// Hence "A" is the TypeParameter and "W" is the FixedType.
    /// A tag WriterTag<W> is created which then is constructed as Construct<WriterTag<W>,A>
    /// or generally,  Construct<Tag<FixedType>,TypeParameter>
    ///
    /// Note that it is not possible to have two "contained" types.
    associatedtype FixedType
    
    
    /// `self` stored in the Tag existential
    var lift: ConstructDual<Tag, FixedType, TypeParameter > { get }
    /// Must unwrap the `app.tag` existential.
    static func lower(_ con: ConstructDual<Tag, FixedType, TypeParameter >) -> ReturnType
}


/// Lift a type to a type constructor with associated tag
public postfix func ^<T>(t: T) -> Construct<T.Tag, T.TypeParameter> where T: _TypeConstructor {
    return t.lift
}

// curry function of 2,3,4 parameters
/// Convert a function like f(a,b) -> c into  f(a) -> (b) -> c
public func curry<A,B,C>(_ f:@escaping (A,B) -> C) -> (A) -> (B) -> C {
    return { a in {b in f(a,b) }}
}

/// Convert a function like f(a,b,c) -> d into  f(a) -> (b) -> (c) -> d
public func curry<A,B,C,D>(_ f:@escaping (A,B,C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in {b in {c in f(a,b,c) }}}
}

/// Convert a function like f(a,b,c,d) -> e into  f(a) -> (b) -> (c) -> (d) -> e
public func curry<A,B,C,D,E>(_ f:@escaping (A,B,C,D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    return { a in {b in {c in { d in f(a,b,c,d) }}}}
}

/// Convert a function like t(a,b,c,d,e) -> f into  t(a) -> (b) -> (c) -> (d) -> (e) -> f
public func curry<A,B,C,D,E,F>(_ f:@escaping (A,B,C,D,E) -> F) -> (A) -> (B) -> (C) -> (D) -> (E) -> F {
    return { a in {b in {c in { d in { e in f(a,b,c,d,e) }}}}}
}
