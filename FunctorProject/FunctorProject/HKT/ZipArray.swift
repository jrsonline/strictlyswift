//
//  ZipArray.swift
//  HKT
//
//  Created by @strictlyswift on 3/19/18.
//

import Foundation


public struct ZipArray<Element> : Constructible, CustomStringConvertible {
    public typealias TypeParameter = Element
    public let array : [Element]
    fileprivate let unsized : Bool
    
    var count : Int { get { return array.count }}
    public var description: String { get { return array.description }}
    
    init(_ ar:[Element], unsized: Bool = false) {
        self.array = ar
        self.unsized = unsized
    }
    
    init(_ vals:Element..., unsized: Bool = false) {
        self.array = vals
        self.unsized = unsized
    }
    
    
    func expandToArray(size: Int) -> Array<Element> {
        if self.unsized {
            return Array(repeatElement(self.array[0], count: size))
        } else {
            return self.array
        }
    }
}

extension ZipArray : Applicative {
    static func pure<A>(_ a: A) -> ZipArray<A> {
        return ZipArray<A>([a], unsized: true)
    }
    
    public func ap<B>(_ fAB: ZipArray<(Element) -> B>) -> ZipArray<B> {
        // must expand out the unsized array to the size of the larger array
        let fexp = fAB.expandToArray(size: max(fAB.count, self.count ))
        let aaexp = self.expandToArray(size: max(fAB.count, self.count ))
        
        return  ZipArray<B>(zip( fexp, aaexp ).map { f,a in f(a) })
    }
}

extension Construct where ConstructorTag == ZipArrayTag
{
    public var toArray: Array<TypeParameter> { get { return lower.array }}
}
