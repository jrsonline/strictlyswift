// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT





//MARK: - HKT for Array


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

func <*><P,Q>(f: Array<(P) -> Q>, p: Array<P>) -> Construct<ArrayTag,Q>
{
    return ArrayTag.ap(f^)(p^)
}
func <*><P,Q>(f: Construct<ArrayTag,(P) -> Q>, p: Array<P>) -> Construct<ArrayTag,Q>
{
return ArrayTag.ap(f)(p^)
}

func <¢><P,Q>(f: @escaping (P) -> Q, p: Array<P>) -> Construct<ArrayTag,Q>
{
    return ArrayTag.ap(ArrayTag.pure(f))(p^)
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
extension Appl5 {
subscript(_ first: Array<A>, _ second: Array<B>, _ third: Array<C>, _ fourth: Array<D>, _ fifth: Array<E>  ) -> Array<F> {
return appl( f: f5, to: first^, second^, third^, fourth^, fifth^ )¬
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




extension ArrayTag : MonadTag {

    // As Array also implements Applicative, no need to implement pure


    public static func bind<A,B>(_ m:Construct<ArrayTag, A> ) -> ( @escaping (A) -> Construct<ArrayTag, B>) -> Construct<ArrayTag, B> {
            return { fA in
                let ml : Array<A> = Array<A>.lower(m)
                let wa : (A) -> Array<B> = { a in Array<B>.lower(fA(a)) }

            // If you get an error on the next line like "Value of type "Array<A> has no member bind"  that is
            // because Array conforms to the Monad protocol but does not also implement this method:
            // public func bind<B>(_ m: (TypeParameter) -> Array<B>) -> Array<B>
            return ml.bind(wa)^
        }
    }
}

extension Array {
    public static func >>>=<B>( left: Array<TypeParameter>, right: @escaping (TypeParameter) -> Array<B>) -> Array<B> {
        return left.bind(right)
    }
}

func >=> <A,B,C> (l: @escaping (A) -> Array<B>, r: @escaping (B) -> Array<C> ) -> (A) -> Array<C> {
return { a in l(a) >>>= r }
}
func >=> <A,B> (l: A, r: @escaping (A) -> Array<B> ) -> Array<B> {
    return Array<A>.pure(l) >>>= r
}





//MARK: - HKT for Future


/// FutureTag is the container type for values of Future
internal struct FutureTag : HKTTag {
    internal typealias ActualType = Future
    fileprivate let _actual: Any
    init<T>(_ actual:Future<T>) { self._actual = actual as Any }
}
extension Future : _TypeConstructor {
    internal typealias Tag = FutureTag

    internal var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

// If you get an error: Method 'lower' in non-final class 'Future<T>' must return 'Self'
// to conform to protocol '_TypeConstructor', then make Future final 
    internal static func lower(_ con: Construct<Tag, TypeParameter>) -> Future<TypeParameter> {
        return con.tag._actual as! Future  
    }
}



extension Construct where ConstructorTag == FutureTag
{
    internal var lower: Future<TypeParameter> { get {
        return Future.lower(self)
    }}

internal var toFuture: Future<TypeParameter> { get { return lower }}
}

internal func >>>¬<A>(left: Construct<FutureTag, A>, right: @escaping (Construct<FutureTag, A>) -> Future<A>) -> Future<A>
{
    return right(left)
}

internal postfix func¬<A>(left: Construct<FutureTag, A>) -> Future<A> {
return left.lower
}

internal func toFuture<A>(_ con:Construct<FutureTag, A>) -> Future<A> {
    return Future<A>.lower(con)
}


extension FutureTag : FunctorTag {
    internal static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<FutureTag, A>) -> Construct<FutureTag, B> {
        return { applyA in
            let a = Future<A>.lower(applyA)

            // If you get an error on the next line like "Value of type "Future<A> has no member fmap"  that is
            // because Future conforms to the Functor protocol but does not also implement this method:
            // internal func fmap<B>(_ transform: @escaping (A) -> B) -> Future<B>
            return a.fmap(transform)^
        }
    }
}

func >>>•<P,Q>(left: Future<P>, right: @escaping (P) -> Q) -> Future<Q>
{
    return left.fmap(right)
}






extension FutureTag : MonadTag {


    internal static func pure<V>(_ v: V) -> Construct<FutureTag, V> {

    // If you get an error on the next line like "Value of type "Future<A> has no member pure"  that is
    // because Future conforms to the Monad protocol but does not also implement this method:
    // internal static func pure<V>(_ v: V) -> Future<V>

        return Future<V>.pure(v)^
    }

    internal static func bind<A,B>(_ m:Construct<FutureTag, A> ) -> ( @escaping (A) -> Construct<FutureTag, B>) -> Construct<FutureTag, B> {
            return { fA in
                let ml : Future<A> = Future<A>.lower(m)
                let wa : (A) -> Future<B> = { a in Future<B>.lower(fA(a)) }

            // If you get an error on the next line like "Value of type "Future<A> has no member bind"  that is
            // because Future conforms to the Monad protocol but does not also implement this method:
            // internal func bind<B>(_ m: (TypeParameter) -> Future<B>) -> Future<B>
            return ml.bind(wa)^
        }
    }
}

extension Future {
    internal static func >>>=<B>( left: Future<TypeParameter>, right: @escaping (TypeParameter) -> Future<B>) -> Future<B> {
        return left.bind(right)
    }
}

func >=> <A,B,C> (l: @escaping (A) -> Future<B>, r: @escaping (B) -> Future<C> ) -> (A) -> Future<C> {
return { a in l(a) >>>= r }
}
func >=> <A,B> (l: A, r: @escaping (A) -> Future<B> ) -> Future<B> {
    return Future<A>.pure(l) >>>= r
}





//MARK: - HKT for LinkedList


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


extension LinkedListTag : FunctorTag {
    public static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<LinkedListTag, A>) -> Construct<LinkedListTag, B> {
        return { applyA in
            let a = LinkedList<A>.lower(applyA)

            // If you get an error on the next line like "Value of type "LinkedList<A> has no member fmap"  that is
            // because LinkedList conforms to the Functor protocol but does not also implement this method:
            // public func fmap<B>(_ transform: @escaping (A) -> B) -> LinkedList<B>
            return a.fmap(transform)^
        }
    }
}

func >>>•<P,Q>(left: LinkedList<P>, right: @escaping (P) -> Q) -> LinkedList<Q>
{
    return left.fmap(right)
}







//MARK: - HKT for Optional


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

func <*><P,Q>(f: Optional<(P) -> Q>, p: Optional<P>) -> Construct<OptionalTag,Q>
{
    return OptionalTag.ap(f^)(p^)
}
func <*><P,Q>(f: Construct<OptionalTag,(P) -> Q>, p: Optional<P>) -> Construct<OptionalTag,Q>
{
return OptionalTag.ap(f)(p^)
}

func <¢><P,Q>(f: @escaping (P) -> Q, p: Optional<P>) -> Construct<OptionalTag,Q>
{
    return OptionalTag.ap(OptionalTag.pure(f))(p^)
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
extension Appl5 {
subscript(_ first: Optional<A>, _ second: Optional<B>, _ third: Optional<C>, _ fourth: Optional<D>, _ fifth: Optional<E>  ) -> Optional<F> {
return appl( f: f5, to: first^, second^, third^, fourth^, fifth^ )¬
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




extension OptionalTag : MonadTag {

    // As Optional also implements Applicative, no need to implement pure


    public static func bind<A,B>(_ m:Construct<OptionalTag, A> ) -> ( @escaping (A) -> Construct<OptionalTag, B>) -> Construct<OptionalTag, B> {
            return { fA in
                let ml : Optional<A> = Optional<A>.lower(m)
                let wa : (A) -> Optional<B> = { a in Optional<B>.lower(fA(a)) }

            // If you get an error on the next line like "Value of type "Optional<A> has no member bind"  that is
            // because Optional conforms to the Monad protocol but does not also implement this method:
            // public func bind<B>(_ m: (TypeParameter) -> Optional<B>) -> Optional<B>
            return ml.bind(wa)^
        }
    }
}

extension Optional {
    public static func >>>=<B>( left: Optional<TypeParameter>, right: @escaping (TypeParameter) -> Optional<B>) -> Optional<B> {
        return left.bind(right)
    }
}

func >=> <A,B,C> (l: @escaping (A) -> Optional<B>, r: @escaping (B) -> Optional<C> ) -> (A) -> Optional<C> {
return { a in l(a) >>>= r }
}
func >=> <A,B> (l: A, r: @escaping (A) -> Optional<B> ) -> Optional<B> {
    return Optional<A>.pure(l) >>>= r
}





//MARK: - HKT for Tree


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






//MARK: - HKT for WebData


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

func <*><P,Q>(f: WebData<(P) -> Q>, p: WebData<P>) -> Construct<WebDataTag,Q>
{
    return WebDataTag.ap(f^)(p^)
}
func <*><P,Q>(f: Construct<WebDataTag,(P) -> Q>, p: WebData<P>) -> Construct<WebDataTag,Q>
{
return WebDataTag.ap(f)(p^)
}

func <¢><P,Q>(f: @escaping (P) -> Q, p: WebData<P>) -> Construct<WebDataTag,Q>
{
    return WebDataTag.ap(WebDataTag.pure(f))(p^)
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
extension Appl5 {
subscript(_ first: WebData<A>, _ second: WebData<B>, _ third: WebData<C>, _ fourth: WebData<D>, _ fifth: WebData<E>  ) -> WebData<F> {
return appl( f: f5, to: first^, second^, third^, fourth^, fifth^ )¬
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




extension WebDataTag : MonadTag {

    // As WebData also implements Applicative, no need to implement pure


    internal static func bind<A,B>(_ m:Construct<WebDataTag, A> ) -> ( @escaping (A) -> Construct<WebDataTag, B>) -> Construct<WebDataTag, B> {
            return { fA in
                let ml : WebData<A> = WebData<A>.lower(m)
                let wa : (A) -> WebData<B> = { a in WebData<B>.lower(fA(a)) }

            // If you get an error on the next line like "Value of type "WebData<A> has no member bind"  that is
            // because WebData conforms to the Monad protocol but does not also implement this method:
            // internal func bind<B>(_ m: (TypeParameter) -> WebData<B>) -> WebData<B>
            return ml.bind(wa)^
        }
    }
}

extension WebData {
    internal static func >>>=<B>( left: WebData<TypeParameter>, right: @escaping (TypeParameter) -> WebData<B>) -> WebData<B> {
        return left.bind(right)
    }
}

func >=> <A,B,C> (l: @escaping (A) -> WebData<B>, r: @escaping (B) -> WebData<C> ) -> (A) -> WebData<C> {
return { a in l(a) >>>= r }
}
func >=> <A,B> (l: A, r: @escaping (A) -> WebData<B> ) -> WebData<B> {
    return WebData<A>.pure(l) >>>= r
}





//MARK: - HKT for ZipArray


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

func <*><P,Q>(f: ZipArray<(P) -> Q>, p: ZipArray<P>) -> Construct<ZipArrayTag,Q>
{
    return ZipArrayTag.ap(f^)(p^)
}
func <*><P,Q>(f: Construct<ZipArrayTag,(P) -> Q>, p: ZipArray<P>) -> Construct<ZipArrayTag,Q>
{
return ZipArrayTag.ap(f)(p^)
}

func <¢><P,Q>(f: @escaping (P) -> Q, p: ZipArray<P>) -> Construct<ZipArrayTag,Q>
{
    return ZipArrayTag.ap(ZipArrayTag.pure(f))(p^)
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
extension Appl5 {
subscript(_ first: ZipArray<A>, _ second: ZipArray<B>, _ third: ZipArray<C>, _ fourth: ZipArray<D>, _ fifth: ZipArray<E>  ) -> ZipArray<F> {
return appl( f: f5, to: first^, second^, third^, fourth^, fifth^ )¬
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







//MARK: - HKT for Reader


/// ReaderTag<FixedType> is the container type for values of Reader<FixedType>
internal struct ReaderTag<FixedType> : HKTTag {
    internal typealias ActualType<A> = Reader<FixedType,A>
    fileprivate let _actual: Any
    init<FixedType ,T>(_ actual:Reader<FixedType,T>) { self._actual = actual as Any }
}
extension Reader : _TypeConstructor {
    internal typealias Tag = ReaderTag<FixedType>

    internal var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    internal static func lower(_ con: Construct<Tag, TypeParameter>) -> Reader<FixedType, TypeParameter> {
        return con.tag._actual as! Reader<FixedType, TypeParameter>  
    }
}



internal func >>>¬<A,FixedType>(left: Construct<ReaderTag<FixedType>, A>, right: @escaping (Construct<ReaderTag<FixedType>, A>) -> Reader<FixedType,A>) -> Reader<FixedType,A>
{
return right(left)
}

internal postfix func¬<A,FixedType>(left: Construct<ReaderTag<FixedType>, A>) -> Reader<FixedType,A> {
    return Reader.lower(left)
}

internal func toReader<A,FixedType>(_ con:Construct<ReaderTag<FixedType>, A>) -> Reader<FixedType,A> {
return Reader<FixedType,A>.lower(con)
}



extension ReaderTag : FunctorTag {
    internal static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<ReaderTag<FixedType>, A>) -> Construct<ReaderTag<FixedType>, B> {
        return { applyA in
            let a = Reader<FixedType,A>.lower(applyA)

            // If you get an error on the next line like "Value of type "Reader<FixedType,A> has no member fmap"  that is
            // because Reader conforms to the Functor protocol but does not also implement this method:
            // internal func fmap<B>(_ transform: @escaping (TypeParameter) -> B) -> Reader<FixedType,B>
            return a.fmap(transform)^
        }
    }
}


extension ReaderTag : MonadTag {


    internal static func pure<V>(_ v: V) -> Construct<ReaderTag<FixedType>, V> {

    // If you get an error on the next line like "Value of type "Reader<A> has no member pure"  that is
    // because Reader conforms to the Monad protocol but does not also implement this method:
    // internal static func pure<V>(_ v: V) -> Reader<FixedType,V>

        return Reader<FixedType,V>.pure(v)^
    }

    internal static func bind<A,B>(_ m:Construct<ReaderTag<FixedType>, A> ) -> ( @escaping (A) -> Construct<ReaderTag<FixedType>, B>) -> Construct<ReaderTag<FixedType>, B> {
        return { fA in
            let ml : Reader<FixedType,A> = Reader<FixedType,A>.lower(m)
            let wa : (A) -> Reader<FixedType,B> = { a in Reader<FixedType,B>.lower(fA(a)) }

            // If you get an error on the next line like "Value of type "Reader<FixedType,A> has no member bind"  that is
            // because Reader conforms to the Monad protocol but does not also implement this method:
            // internal func bind<B>(_ m: (TypeParameter) -> Reader<FixedType,B>) -> Reader<FixedType,B>
            return ml.bind(wa)^
        }
    }
}

func >=> <FixedType,A,B,C> (l: @escaping (A) -> Reader<FixedType,B>, r: @escaping (B) -> Reader<FixedType,C> ) -> (A) -> Reader<FixedType,C> {
return { a in l(a) >>>= r }
}
func >=> <FixedType,A,B> (l: A, r: @escaping (A) -> Reader<FixedType,B> ) -> Reader<FixedType,B> {
return Reader<FixedType,A>.pure(l) >>>= r
}

extension Reader {
internal static func >>>=<B>( left: Reader<FixedType,TypeParameter>, right: @escaping (TypeParameter) -> Reader<FixedType,B>) -> Reader<FixedType,B> {
return left.bind(right)
}
}



//MARK: - HKT for Writer


/// WriterTag<FixedType> is the container type for values of Writer<FixedType>
internal struct WriterTag<FixedType: Monoid > : HKTTag {
    internal typealias ActualType<A> = Writer<FixedType,A>
    fileprivate let _actual: Any
    init<FixedType ,T>(_ actual:Writer<FixedType,T>) { self._actual = actual as Any }
}
extension Writer : _TypeConstructor {
    internal typealias Tag = WriterTag<FixedType>

    internal var lift: Construct<Tag, TypeParameter> {
        return Construct<Tag, TypeParameter>(tag: Tag(self))
    }

    internal static func lower(_ con: Construct<Tag, TypeParameter>) -> Writer<FixedType, TypeParameter> {
        return con.tag._actual as! Writer<FixedType, TypeParameter>  
    }
}



internal func >>>¬<A,FixedType>(left: Construct<WriterTag<FixedType>, A>, right: @escaping (Construct<WriterTag<FixedType>, A>) -> Writer<FixedType,A>) -> Writer<FixedType,A>
{
return right(left)
}

internal postfix func¬<A,FixedType>(left: Construct<WriterTag<FixedType>, A>) -> Writer<FixedType,A> {
    return Writer.lower(left)
}

internal func toWriter<A,FixedType>(_ con:Construct<WriterTag<FixedType>, A>) -> Writer<FixedType,A> {
return Writer<FixedType,A>.lower(con)
}



extension WriterTag : FunctorTag {
    internal static func fmap<A, B>(_ transform: @escaping (A) -> B) -> (Construct<WriterTag<FixedType>, A>) -> Construct<WriterTag<FixedType>, B> {
        return { applyA in
            let a = Writer<FixedType,A>.lower(applyA)

            // If you get an error on the next line like "Value of type "Writer<FixedType,A> has no member fmap"  that is
            // because Writer conforms to the Functor protocol but does not also implement this method:
            // internal func fmap<B>(_ transform: @escaping (TypeParameter) -> B) -> Writer<FixedType,B>
            return a.fmap(transform)^
        }
    }
}


extension WriterTag : MonadTag {


    internal static func pure<V>(_ v: V) -> Construct<WriterTag<FixedType>, V> {

    // If you get an error on the next line like "Value of type "Writer<A> has no member pure"  that is
    // because Writer conforms to the Monad protocol but does not also implement this method:
    // internal static func pure<V>(_ v: V) -> Writer<FixedType,V>

        return Writer<FixedType,V>.pure(v)^
    }

    internal static func bind<A,B>(_ m:Construct<WriterTag<FixedType>, A> ) -> ( @escaping (A) -> Construct<WriterTag<FixedType>, B>) -> Construct<WriterTag<FixedType>, B> {
        return { fA in
            let ml : Writer<FixedType,A> = Writer<FixedType,A>.lower(m)
            let wa : (A) -> Writer<FixedType,B> = { a in Writer<FixedType,B>.lower(fA(a)) }

            // If you get an error on the next line like "Value of type "Writer<FixedType,A> has no member bind"  that is
            // because Writer conforms to the Monad protocol but does not also implement this method:
            // internal func bind<B>(_ m: (TypeParameter) -> Writer<FixedType,B>) -> Writer<FixedType,B>
            return ml.bind(wa)^
        }
    }
}

func >=> <FixedType,A,B,C> (l: @escaping (A) -> Writer<FixedType,B>, r: @escaping (B) -> Writer<FixedType,C> ) -> (A) -> Writer<FixedType,C> {
return { a in l(a) >>>= r }
}
func >=> <FixedType,A,B> (l: A, r: @escaping (A) -> Writer<FixedType,B> ) -> Writer<FixedType,B> {
return Writer<FixedType,A>.pure(l) >>>= r
}

extension Writer {
internal static func >>>=<B>( left: Writer<FixedType,TypeParameter>, right: @escaping (TypeParameter) -> Writer<FixedType,B>) -> Writer<FixedType,B> {
return left.bind(right)
}
}





