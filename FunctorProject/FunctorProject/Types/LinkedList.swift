//
//  LinkedList.swift
//  HKT
//
//  Created by @strictlyswift on 1/23/18.
//

import Foundation

public protocol Linkable : AnyObject, Equatable {
    var next: Self? { get set }
    var prev: Self? { get set }
    
}

public final class LinkableBox<T> : Linkable {
    var boxed: T
    public var next: LinkableBox<T>? = nil
    public var prev: LinkableBox<T>? = nil
    
    init(_ t:T) {
        boxed = t
    }
    
    public static func ==(lhs: LinkableBox, rhs: LinkableBox) -> Bool {
        return lhs === rhs
    }
}

public class LinkedListIterator<T> : IteratorProtocol {
    var _iteratorPosn: LinkableBox<T>?  = nil
    
    public required init( _ fromList: LinkableBox<T>?) {
        _iteratorPosn = fromList
    }
    
    public func next() -> T? {
        guard let iteratorPosn = _iteratorPosn else { return nil }
        
        let elt = iteratorPosn
        self._iteratorPosn = iteratorPosn.next
        return elt.boxed
    }
    
}

public final class LinkedList<T> : Sequence, CustomStringConvertible  {
    
    typealias Box = LinkableBox<T>
    public typealias Element = T
    
    fileprivate var _first: Box? = nil
    fileprivate var _last: Box? = nil
    
    public init(){
    }
    
    public init(array elements: [T]) {
        for e in elements {
            self.addToEnd(e)
        }
    }
    
    public static func start(_ e:T) -> LinkedList<T> {
        let l = LinkedList<T>()
        return l.addToEnd(e)
    }
    
    var last: T? { get { return _last?.boxed } }
    var first: T? { get { return _first?.boxed } }
    
    @discardableResult public func addToEnd(_  element: T ) -> LinkedList<T> {
        let boxed = LinkableBox(element)
        if _last == nil {
            _first = boxed
            _last = boxed
        } else {
            _last!.next = boxed
            boxed.prev = _last
            _last = boxed
        }
        return self
    }
    
    @discardableResult public func addToStart(_ element: T) -> LinkedList<T> {
        let boxed = LinkableBox(element)
        
        if _first == nil {
            _first = boxed
            _last = boxed
        } else {
            _first!.prev = boxed
            boxed.next = _first
            _first = boxed
        }
        return self
    }
    
    public var description: String {
        var acc : [String] = []
        var it = _first
        while let itv = it {
            acc += ["\(itv.boxed)"]
            it = itv.next
        }
        return "⟪" + acc.joined(separator: ", ") + "⟫"
    }
    
    public func makeIterator() -> LinkedListIterator<T>  {
        return LinkedListIterator(_first)
    }
    
    public func lmap<S>(_ transform:(T) -> S) -> LinkedList<S> {
        let l = LinkedList<S>()
        for a in self {
            l.addToEnd(transform(a))
        }
        return l
    }
    
}

extension LinkedList : Constructible {
    public typealias TypeParameter = T
}

extension LinkedList : Functor {
    public func fmap<B>(_ transform: @escaping (Element) -> B) -> LinkedList<B> {
        return self.lmap(transform)
    }
}
