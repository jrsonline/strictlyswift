// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT





// Array IMPLEMENTATION OF HIGHER KINDED TYPES


/// ArrayTag is the container type for values of Array
public struct ArrayTag : HKTTag {
    public typealias ActualType = Array
    fileprivate let _actual: Any
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

public postfix func¬<A>(left: Construct<ArrayTag, A>) -> Array<A> {
return left.lower
}

public func toArray<A>(_ con:Construct<ArrayTag, A>) -> Array<A> {
    return Array<A>.lower(con)
}




extension ArrayTag : ApplicativeTag {
    public static func pure<A>(_ a: A) -> Construct<ArrayTag, A> {

        // If you get an error on the next line like "Value of type "Array<A> has no member pure"  that is
        // because Array conforms to the Applicative protocol but does not also implement this method:
        // public static func pure<V>(_ v: V) -> Array<V>
        return Array<A>.pure(a)^
    }

    public static func ap<A, B>(_ fAB: Construct<ArrayTag, (A) -> B>) -> (Construct<ArrayTag, A>) -> Construct<ArrayTag, B> {
        return { fA in
            let fab = Array<(A)->B>.lower(fAB)
            let wa = Array<A>.lower(fA)

            // If you get an error on the next line like "Value of type "Array<A> has no member ap"  that is
            // because Array conforms to the Applicative protocol but does not also implement this method:
            // public func ap<B>(_ fAB: Array<(TypeParameter) -> B>) -> Array<B>
            return wa.ap(fab)^
        }
    }
}

extension Appl2 {
    subscript(_ first: Array<A>, _ second: Array<B> ) -> Array<C> {
        return appl( f: f2, to: first^, second^ )¬
    }
}
extension Appl3 {
    subscript(_ first: Array<A>, _ second: Array<B>, _ third: Array<C> ) -> Array<D> {
        return appl( f: f3, to: first^, second^, third^ )¬
    }
}
extension Appl4 {
subscript(_ first: Array<A>, _ second: Array<B>, _ third: Array<C>, _ fourth: Array<D>  ) -> Array<E> {
return appl( f: f4, to: first^, second^, third^, fourth^ )¬
}
}

extension ApplReduce {
subscript(_ params: Array<Elt>...) -> Array<Elt> {
return self.to(params.map(^))¬
}
}


// Auto-generating Functor instance from Applicative
extension Array : Functor   {
    public func fmap<B>(_ transform: @escaping (TypeParameter) -> B) -> Array<B> {
        return self.ap(Array.pure(transform))
    }
}

extension ArrayTag : FunctorTag {
    public static func fmap<TypeParameter, B>(_ transform: @escaping (TypeParameter) -> B) -> (Construct<ArrayTag, TypeParameter>) -> Construct<ArrayTag, B> {
        return { applyA in
            let a = Array<TypeParameter>.lower(applyA)
            return a.fmap(transform)^
        }
    }
}





// LinkedList IMPLEMENTATION OF HIGHER KINDED TYPES


/// LinkedListTag is the container type for values of LinkedList
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
// to conform to protocol '_TypeConstructor', then make LinkedList final 
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

public postfix func¬<A>(left: Construct<LinkedListTag, A>) -> LinkedList<A> {
return left.lower
}

public func toLinkedList<A>(_ con:Construct<LinkedListTag, A>) -> LinkedList<A> {
    return LinkedList<A>.lower(con)
}






// Optional IMPLEMENTATION OF HIGHER KINDED TYPES


/// OptionalTag is the container type for values of Optional
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

public postfix func¬<A>(left: Construct<OptionalTag, A>) -> Optional<A> {
return left.lower
}

public func toOptional<A>(_ con:Construct<OptionalTag, A>) -> Optional<A> {
    return Optional<A>.lower(con)
}




extension OptionalTag : ApplicativeTag {
    public static func pure<A>(_ a: A) -> Construct<OptionalTag, A> {

        // If you get an error on the next line like "Value of type "Optional<A> has no member pure"  that is
        // because Optional conforms to the Applicative protocol but does not also implement this method:
        // public static func pure<V>(_ v: V) -> Optional<V>
        return Optional<A>.pure(a)^
    }

    public static func ap<A, B>(_ fAB: Construct<OptionalTag, (A) -> B>) -> (Construct<OptionalTag, A>) -> Construct<OptionalTag, B> {
        return { fA in
            let fab = Optional<(A)->B>.lower(fAB)
            let wa = Optional<A>.lower(fA)

            // If you get an error on the next line like "Value of type "Optional<A> has no member ap"  that is
            // because Optional conforms to the Applicative protocol but does not also implement this method:
            // public func ap<B>(_ fAB: Optional<(TypeParameter) -> B>) -> Optional<B>
            return wa.ap(fab)^
        }
    }
}

extension Appl2 {
    subscript(_ first: Optional<A>, _ second: Optional<B> ) -> Optional<C> {
        return appl( f: f2, to: first^, second^ )¬
    }
}
extension Appl3 {
    subscript(_ first: Optional<A>, _ second: Optional<B>, _ third: Optional<C> ) -> Optional<D> {
        return appl( f: f3, to: first^, second^, third^ )¬
    }
}
extension Appl4 {
subscript(_ first: Optional<A>, _ second: Optional<B>, _ third: Optional<C>, _ fourth: Optional<D>  ) -> Optional<E> {
return appl( f: f4, to: first^, second^, third^, fourth^ )¬
}
}

extension ApplReduce {
subscript(_ params: Optional<Elt>...) -> Optional<Elt> {
return self.to(params.map(^))¬
}
}


// Auto-generating Functor instance from Applicative
extension Optional : Functor   {
    public func fmap<B>(_ transform: @escaping (TypeParameter) -> B) -> Optional<B> {
        return self.ap(Optional.pure(transform))
    }
}

extension OptionalTag : FunctorTag {
    public static func fmap<TypeParameter, B>(_ transform: @escaping (TypeParameter) -> B) -> (Construct<OptionalTag, TypeParameter>) -> Construct<OptionalTag, B> {
        return { applyA in
            let a = Optional<TypeParameter>.lower(applyA)
            return a.fmap(transform)^
        }
    }
}





// Tree IMPLEMENTATION OF HIGHER KINDED TYPES


/// TreeTag is the container type for values of Tree
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

public postfix func¬<A>(left: Construct<TreeTag, A>) -> Tree<A> {
return left.lower
}

public func toTree<A>(_ con:Construct<TreeTag, A>) -> Tree<A> {
    return Tree<A>.lower(con)
}






// WebData IMPLEMENTATION OF HIGHER KINDED TYPES


/// WebDataTag is the container type for values of WebData
internal struct WebDataTag : HKTTag {
    internal typealias ActualType = WebData
    fileprivate let _actual: Any
    init<T>(_ actual:WebData<T>) { self._actual = actual as Any }
}
extension WebData : _TypeConstructor {
    internal typealias Tag = WebDataTag

    internal var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    internal static func lower(_ con: Construct<Tag, TypeParameter>) -> WebData<TypeParameter> {
        return con.tag._actual as! WebData  
    }
}



extension Construct where ConstructorTag == WebDataTag
{
    internal var lower: WebData<TypeParameter> { get {
        return WebData.lower(self)
    }}

internal var toWebData: WebData<TypeParameter> { get { return lower }}
}

internal func >>>¬<A>(left: Construct<WebDataTag, A>, right: @escaping (Construct<WebDataTag, A>) -> WebData<A>) -> WebData<A>
{
    return right(left)
}

internal postfix func¬<A>(left: Construct<WebDataTag, A>) -> WebData<A> {
return left.lower
}

internal func toWebData<A>(_ con:Construct<WebDataTag, A>) -> WebData<A> {
    return WebData<A>.lower(con)
}




extension WebDataTag : ApplicativeTag {
    internal static func pure<A>(_ a: A) -> Construct<WebDataTag, A> {

        // If you get an error on the next line like "Value of type "WebData<A> has no member pure"  that is
        // because WebData conforms to the Applicative protocol but does not also implement this method:
        // internal static func pure<V>(_ v: V) -> WebData<V>
        return WebData<A>.pure(a)^
    }

    internal static func ap<A, B>(_ fAB: Construct<WebDataTag, (A) -> B>) -> (Construct<WebDataTag, A>) -> Construct<WebDataTag, B> {
        return { fA in
            let fab = WebData<(A)->B>.lower(fAB)
            let wa = WebData<A>.lower(fA)

            // If you get an error on the next line like "Value of type "WebData<A> has no member ap"  that is
            // because WebData conforms to the Applicative protocol but does not also implement this method:
            // internal func ap<B>(_ fAB: WebData<(TypeParameter) -> B>) -> WebData<B>
            return wa.ap(fab)^
        }
    }
}

extension Appl2 {
    subscript(_ first: WebData<A>, _ second: WebData<B> ) -> WebData<C> {
        return appl( f: f2, to: first^, second^ )¬
    }
}
extension Appl3 {
    subscript(_ first: WebData<A>, _ second: WebData<B>, _ third: WebData<C> ) -> WebData<D> {
        return appl( f: f3, to: first^, second^, third^ )¬
    }
}
extension Appl4 {
subscript(_ first: WebData<A>, _ second: WebData<B>, _ third: WebData<C>, _ fourth: WebData<D>  ) -> WebData<E> {
return appl( f: f4, to: first^, second^, third^, fourth^ )¬
}
}

extension ApplReduce {
subscript(_ params: WebData<Elt>...) -> WebData<Elt> {
return self.to(params.map(^))¬
}
}


// Auto-generating Functor instance from Applicative
extension WebData : Functor   {
    public func fmap<B>(_ transform: @escaping (TypeParameter) -> B) -> WebData<B> {
        return self.ap(WebData.pure(transform))
    }
}

extension WebDataTag : FunctorTag {
    internal static func fmap<TypeParameter, B>(_ transform: @escaping (TypeParameter) -> B) -> (Construct<WebDataTag, TypeParameter>) -> Construct<WebDataTag, B> {
        return { applyA in
            let a = WebData<TypeParameter>.lower(applyA)
            return a.fmap(transform)^
        }
    }
}





// ZipArray IMPLEMENTATION OF HIGHER KINDED TYPES


/// ZipArrayTag is the container type for values of ZipArray
public struct ZipArrayTag : HKTTag {
    public typealias ActualType = ZipArray
    fileprivate let _actual: Any
    init<T>(_ actual:ZipArray<T>) { self._actual = actual as Any }
}
extension ZipArray : _TypeConstructor {
    public typealias Tag = ZipArrayTag

    public var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    public static func lower(_ con: Construct<Tag, TypeParameter>) -> ZipArray<TypeParameter> {
        return con.tag._actual as! ZipArray  
    }
}



extension Construct where ConstructorTag == ZipArrayTag
{
    public var lower: ZipArray<TypeParameter> { get {
        return ZipArray.lower(self)
    }}

public var toZipArray: ZipArray<TypeParameter> { get { return lower }}
}

public func >>>¬<A>(left: Construct<ZipArrayTag, A>, right: @escaping (Construct<ZipArrayTag, A>) -> ZipArray<A>) -> ZipArray<A>
{
    return right(left)
}

public postfix func¬<A>(left: Construct<ZipArrayTag, A>) -> ZipArray<A> {
return left.lower
}

public func toZipArray<A>(_ con:Construct<ZipArrayTag, A>) -> ZipArray<A> {
    return ZipArray<A>.lower(con)
}




extension ZipArrayTag : ApplicativeTag {
    public static func pure<A>(_ a: A) -> Construct<ZipArrayTag, A> {

        // If you get an error on the next line like "Value of type "ZipArray<A> has no member pure"  that is
        // because ZipArray conforms to the Applicative protocol but does not also implement this method:
        // public static func pure<V>(_ v: V) -> ZipArray<V>
        return ZipArray<A>.pure(a)^
    }

    public static func ap<A, B>(_ fAB: Construct<ZipArrayTag, (A) -> B>) -> (Construct<ZipArrayTag, A>) -> Construct<ZipArrayTag, B> {
        return { fA in
            let fab = ZipArray<(A)->B>.lower(fAB)
            let wa = ZipArray<A>.lower(fA)

            // If you get an error on the next line like "Value of type "ZipArray<A> has no member ap"  that is
            // because ZipArray conforms to the Applicative protocol but does not also implement this method:
            // public func ap<B>(_ fAB: ZipArray<(TypeParameter) -> B>) -> ZipArray<B>
            return wa.ap(fab)^
        }
    }
}

extension Appl2 {
    subscript(_ first: ZipArray<A>, _ second: ZipArray<B> ) -> ZipArray<C> {
        return appl( f: f2, to: first^, second^ )¬
    }
}
extension Appl3 {
    subscript(_ first: ZipArray<A>, _ second: ZipArray<B>, _ third: ZipArray<C> ) -> ZipArray<D> {
        return appl( f: f3, to: first^, second^, third^ )¬
    }
}
extension Appl4 {
subscript(_ first: ZipArray<A>, _ second: ZipArray<B>, _ third: ZipArray<C>, _ fourth: ZipArray<D>  ) -> ZipArray<E> {
return appl( f: f4, to: first^, second^, third^, fourth^ )¬
}
}

extension ApplReduce {
subscript(_ params: ZipArray<Elt>...) -> ZipArray<Elt> {
return self.to(params.map(^))¬
}
}


// Auto-generating Functor instance from Applicative
extension ZipArray : Functor   {
    public func fmap<B>(_ transform: @escaping (TypeParameter) -> B) -> ZipArray<B> {
        return self.ap(ZipArray.pure(transform))
    }
}

extension ZipArrayTag : FunctorTag {
    public static func fmap<TypeParameter, B>(_ transform: @escaping (TypeParameter) -> B) -> (Construct<ZipArrayTag, TypeParameter>) -> Construct<ZipArrayTag, B> {
        return { applyA in
            let a = ZipArray<TypeParameter>.lower(applyA)
            return a.fmap(transform)^
        }
    }
}









