// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


postfix operator ¬

public struct ArrayTag : HKTTag {
    public typealias ActualType = Array
    fileprivate var _actual: Any
    init<T>(_ actual:Array<T>) { self._actual = actual as Any }
}
extension Array : _TypeConstructor {
    public typealias Tag = ArrayTag

    public var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    public static func lower(_ con: Construct<Tag, TypeParameter>) -> Array<TypeParameter> {
        return con.tag._actual as! Array  
    }
}

extension Construct where ConstructorTag == ArrayTag
{
    public var lower: Array<TypeParameter> { get {
        return Array.lower(self)
    }}

public var toArray: Array<TypeParameter> { get { return lower }}
}

public func >>>¬<A>(left: Construct<ArrayTag, A>, right: @escaping (Construct<ArrayTag, A>) -> Array<A>) -> Array<A>
{
    return right(left)
}



public func toArray<A>(_ con:Construct<ArrayTag, A>) -> Array<A> {
    return Array<A>.lower(con)
}



public struct LinkedListTag : HKTTag {
    public typealias ActualType = LinkedList
    fileprivate let _actual: Any
    init<T>(_ actual:LinkedList<T>) { self._actual = actual as Any }
}
extension LinkedList : _TypeConstructor {
    public typealias Tag = LinkedListTag

    public var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

// If you get an error: Method 'lower' in non-final class 'LinkedList<T>' must return 'Self'
// to conform to protocol 'Type Constructor', then make LinkedList final 
    public static func lower(_ con: Construct<Tag, TypeParameter>) -> LinkedList<TypeParameter> {
        return con.tag._actual as! LinkedList  
    }
}

extension Construct where ConstructorTag == LinkedListTag
{
    public var lower: LinkedList<TypeParameter> { get {
        return LinkedList.lower(self)
    }}

public var toLinkedList: LinkedList<TypeParameter> { get { return lower }}
}

public func >>>¬<A>(left: Construct<LinkedListTag, A>, right: @escaping (Construct<LinkedListTag, A>) -> LinkedList<A>) -> LinkedList<A>
{
    return right(left)
}

public func toLinkedList<A>(_ con:Construct<LinkedListTag, A>) -> LinkedList<A> {
    return LinkedList<A>.lower(con)
}


public postfix func¬<A>(left: Construct<LinkedListTag, A>) -> LinkedList<A> {
    return left.lower
}

public postfix func¬<A>(left: Construct<ArrayTag, A>) -> Array<A> {
    return left.lower
}

public struct OptionalTag : HKTTag {
    public typealias ActualType = Optional
    fileprivate let _actual: Any
    init<T>(_ actual:Optional<T>) { self._actual = actual as Any }
}
extension Optional : _TypeConstructor {
    public typealias Tag = OptionalTag

    public var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    public static func lower(_ con: Construct<Tag, TypeParameter>) -> Optional<TypeParameter> {
        return con.tag._actual as? Wrapped  
    }
}

extension Construct where ConstructorTag == OptionalTag
{
    public var lower: Optional<TypeParameter> { get {
        return Optional.lower(self)
    }}

public var toOptional: Optional<TypeParameter> { get { return lower }}
}

public func >>>¬<A>(left: Construct<OptionalTag, A>, right: @escaping (Construct<OptionalTag, A>) -> Optional<A>) -> Optional<A>
{
    return right(left)
}

public func toOptional<A>(_ con:Construct<OptionalTag, A>) -> Optional<A> {
    return Optional<A>.lower(con)
}




public struct TreeTag : HKTTag {
    public typealias ActualType = Tree
    fileprivate let _actual: Any
    init<T>(_ actual:Tree<T>) { self._actual = actual as Any }
}
extension Tree : _TypeConstructor {
    public typealias Tag = TreeTag

    public var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    public static func lower(_ con: Construct<Tag, TypeParameter>) -> Tree<TypeParameter> {
        return con.tag._actual as! Tree  
    }
}

extension Construct where ConstructorTag == TreeTag
{
    public var lower: Tree<TypeParameter> { get {
        return Tree.lower(self)
    }}

public var toTree: Tree<TypeParameter> { get { return lower }}
}

public func >>>¬<A>(left: Construct<TreeTag, A>, right: @escaping (Construct<TreeTag, A>) -> Tree<A>) -> Tree<A>
{
    return right(left)
}

public func toTree<A>(_ con:Construct<TreeTag, A>) -> Tree<A> {
    return Tree<A>.lower(con)
}

