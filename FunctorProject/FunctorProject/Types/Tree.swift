//
//  Tree.swift
//  HKT
//
//  Created by JonLily on 1/23/18.
//  Copyright © 2018 jsoft-online. All rights reserved.
//

import Foundation

public indirect enum Tree<Element> {
    case leaf(Element)
    case node(left:Tree<Element>, right:Tree<Element>)
    
    public func tmap<B>(_ transform: @escaping (Element) -> B) -> Tree<B> {
        switch self {
        case let .leaf(a) : return .leaf(transform(a))
        case let .node(left:tl, right:tr) : return .node(left:tl.tmap(transform), right: tr.tmap(transform))
        }
    }
}

extension Tree: Constructible {
    public typealias TypeParameter = Element
}

extension TreeTag: FunctorTag {
    public static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<TreeTag, A>) -> Construct<TreeTag, B> {
        return { applyA in
            return Tree<A>.lower(applyA).tmap(transform)^
        }
    }
}

