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

extension ArrayTag : FunctorTag {
    public static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<ArrayTag, A>) -> Construct<ArrayTag, B> {
        return { applyA in
            return [A].lower(applyA).map( transform )^
        }
    }
}

extension OptionalTag : FunctorTag {
    public static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<OptionalTag, A>) -> Construct<OptionalTag, B> {
        return { applyA in
            return A?.lower(applyA).flatMap(transform)^
        }
    }
}



