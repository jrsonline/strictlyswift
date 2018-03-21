//
//  WebData.swift
//  HKT
//
//  Created by JonLily on 3/9/18.
//  Copyright © 2018 jsoft-online. All rights reserved.
//

import Foundation

enum WebData<A> : Constructible, CustomStringConvertible {
    typealias TypeParameter = A
    case safe(A)
    case taint(A)
  
    init(_ a:A) {
        self = .taint(a)
    }
    
    var description: String { get {
        switch self {
        case .safe(let a): return "\(a)"
        case .taint(let a): return "TAINTED:[\(a)]"
        }
        }
    }
    
    func clean() -> WebData<A> {
        switch self {
        case .safe(_): return self
        case .taint(let a): return .safe(a)  // in reality, do some scrubbing!
        }
    }
}

extension WebData where A:Numeric {
    static func +(left: WebData<A>, right:WebData<A>) -> WebData<A> {
        switch (left, right) {
        case let (.safe(l), .safe(r)): return .safe( l+r )
        case let (.safe(l), .taint(r)): return .taint( l+r )
        case let (.taint(l), .safe(r)): return .taint( l+r )
        case let (.taint(l), .taint(r)): return .taint( l+r )
        }
    }
}

// Turn WebData into an Applicative Functor
// If a type is declared to be an Applicative Functor, a fmap definition will be synthesized automatically !

extension WebData : Applicative {
    public static func pure<V>(_ v: V) -> WebData<V> {
        return WebData<V>.safe(v)
    }
    
    public func ap<B>(_ fab: WebData<(A) -> B>) -> WebData<B> {
        switch (fab, self) {
        case let (.safe(f), .safe(a)): return WebData<B>.safe( f(a) )
        case let (.safe(f), .taint(a)): return WebData<B>.taint( f(a) )
        case let (.taint(f), .safe(a)): return WebData<B>.taint( f(a) )
        case let (.taint(f), .taint(a)): return WebData<B>.taint( f(a) )
        }
    }
    
}
