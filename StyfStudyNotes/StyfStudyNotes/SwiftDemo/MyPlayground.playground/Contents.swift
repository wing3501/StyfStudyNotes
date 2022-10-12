import UIKit


let digits = /\d+/

var str = "Hello, playground"
let arr = str.utf8

var namesOfIntegers = [Int: String]()
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
//person["name", default: "Anonymous"]

//数组

//推荐:
//
//var names: [String] = []
//var lookup: [String: Int] = [:]
//不推荐:
//
//var names = [String]()
//var lookup = [String: Int]()

var someStrs = [String]()
someStrs.append("Apple")
someStrs.append("Amazon")
someStrs.append("Runoob")
someStrs += ["Google"]
for (index, item) in someStrs.enumerated() {
    print("在 index = \(index) 位置上的值为 \(item)")
}
//合并
var intsA = [Int](repeating: 2, count:2)
var intsB = [Int](repeating: 1, count:3)

var intsC = intsA + intsB

//元组
let http404Error = (404, "Not Found")
print(http404Error.1)

let (code, msg) = http404Error
print(msg)

let (code1, _) = http404Error

let http200Status = (statusCode: 200, message: "OK")
print(http200Status.message)


//流程控制
var num = -1
repeat {
    print("num is \(num)")
} while num > 0

//for

for i in 0...3 {
    print(i)
}
let range = 1...3

for i in range {
    print(i)
}

let a = 1
for i in a...3 {
    print(i)
}

let names = ["a", "b", "c", "d"]
for name in names[0...3] {//name[2...] ...2 ..<2
    print(name)
}

//区间类型
let range1: ClosedRange<Int> = 1...3
let range2: Range<Int> = 1..<3
let range3: PartialRangeThrough<Int> = ...5
let stringRange1 = "cc"..."ff"
stringRange1.contains("cb")

//switch
//默认可以不写break，不会穿透
//case、default后面不能写大括号{}
//case、default后面至少有一条语句
//需要处理所有情况

var number = 1
switch number {
case 1:
    print("1")
    fallthrough //穿透
default:
    print("other")
}

let string = "aaa" //支持Character、String
switch string {
case "bbb":
    fallthrough
case "ccc", "ddd":
    break
default:
    break
}

let count = 62 //区间匹配
switch count {
case 0...100:
    break
default:
    break
}

let point = (1, 1)//元组匹配
switch point {
case (_, 0):
    break
case (1...3,2...4):
    break
default:
    break
}

switch point {//值绑定
case (let x, 0):
    print(x)
case let (x, y):
    print("\(x) + \(y)")
}

switch point {//where
case let (x, y) where x == y:
    print("\(x) + \(y)")
default:
    break
}

// 可选类型绑定
//AddressEncoder.addressFor(location: location) { address, error in
//          switch (address, error) {
//          case (nil, let error?):
//            continuation.resume(throwing: error)
//          case (let address?, nil):
//            continuation.resume(returning: address)
//          case (nil, nil):
//            continuation.resume(throwing: "Address encoding failed")
//          case let (address?, error?):
//            continuation.resume(returning: address)
//            print(error)
//          }
//        }

//标签语句
outer: for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
    }
}

//函数
func calculate(v1: Int = 1, v2: Int) -> (sum: Int, diff: Int, ave: Int) {//默认参数 返回元组
    let sum = v1 + v2
    return (sum, v1 - v2, sum >> 1)
}

//可变参数
func sum(_ numbers: Int...) -> Int {
    var total = 0
    for item in numbers {
        total += item
    }
    return total
}

//print
print(1,2,3,4,5, separator: "_", terminator: ".")

//inout
//inout参数不能有默认值
//inout参数本质是地址传递

//函数重载
//参数个数不同 || 参数类型不同 || 参数标签不同
//与返回值无关

//@inline Release模式下会自动决定哪些函数内联，因此没必要用
//永远不会被内联
@inline(never) func test1() {
}
//总是内联
@inline(__always) func test2() {
}

//函数类型
func sum1(a: Int,b: Int) -> Int {
    a + b
}
var fn: (Int, Int) -> Int = sum1

func forward() -> (Int, Int) -> Int {
    return sum1
}

//typealias
typealias Byte = Int8


//枚举
//关联值
enum Date {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}

var date = Date.digit(year:2011, month:9, day: 10)
date = .string("2011-09-10")
switch date {
    case .digit(let year, let month, let day):
        print(year,month, day)
    case let . string(value):
        print(value)
}

//原始值
//原始值不占内存
//枚举的原始值是Int、String的话，会自动分配
enum Grade: String {
    case perfect = "A"
    case great = "B"
}

//递归枚举
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr)
}

//MemoryLayout
enum Password {
    case number(Int, Int, Int, Int)
    case other
}
MemoryLayout<Password>.stride//40 分配占用的空间大小
MemoryLayout<Password>.size// 33 实际用到的空间大小
MemoryLayout<Password>.alignment// 8 对齐参数

var pwd = Password.number(1, 2, 3, 4)
MemoryLayout.stride(ofValue: pwd)
MemoryLayout.size(ofValue: pwd)
MemoryLayout.alignment(ofValue: pwd)


//可选项绑定
if let first = Int("4"),let second = Int("42"),first < second && second < 100 {
    print(first,second)
}

//循环中使用可选项绑定   遇到不满足的条件，就停止遍历
var strs = ["10", "20", "abc", "-20"]
var index = 0
var sum2 = 0
while let num = Int(strs[index]), num > 0 {
    sum2 += num
    index += 1
}

//空合并运算符
// a ?? b
// 如果b不是可选项，返回a时会自动解包

//guard
//guard解包后，绑定的变量、常量外层作用域也可以使用

//隐式解包
let num3: Int! = 10

//结构体
//结构体都有一个编译器自动生成的初始化器,宗旨是保证每个成员都有值
//Swift标准库里的值类型，都采取了Copy On Write技术，如String、Array、Dictionary、Set

//类
//如果类的所有成员都在定义的时候指定了初始值，编译器会为类生成无参的初始化器

//尾随闭包
//为了增加最后参数是闭包时的可读性
func exec(v1: Int,fn: (Int, Int)-> Int) {
    
}

exec(v1: 1) { (a, b) -> Int in
    return 1
}

//闭包定义
//一个函数和它所捕获的变量组合起来，称为闭包
//捕获一个Int变量后，申请了24字节空间
//8 类型信息
//8 引用计数
//8 变量值

//自动闭包
func getFirstPositive(_ v1: Int,_ v2: @autoclosure () -> Int) -> Int {
    return v1 > 0 ? v1 : v2()
}

getFirstPositive(1, 2)

//属性
struct Circle {
    //存储属性
    var radius: Double {
        //属性观察器 也可以用在全局变量、局部变量
        //父类的属性在自己的初始化器中赋值不会触发观察器，在子类的初始化器中会
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue, radius)
        }
    }
    //延迟存储属性 必须是var
//    使用延迟属性注意点
//    1 如果多条线程同时第一次访问延迟属性，无法保证属性只被初始化1次。因此，延迟属性不是线程安全的。
//    2 当结构体包含一个延迟属性时，只有var修饰实例 才能访问延迟属性，因为延迟属性初始化时需要改变结构体的内存
    lazy var radius1: Double = 1
    //计算属性
    var diameter: Double {
        set {
            radius = newValue / 2
        }
        get {
            radius * 2
        }
    }
}

//inout本质
//如果实参有物理内存地址，且没有设置属性观察器-->直接引用传递
//如果实参是计算属性 或 设置了属性观察器-->先复制实参的值，到一个局部变量，把局部变量的地址传入函数 函数返回后，将局部变量的值传给实参（Copy In Copy Out）

//类型属性 默认就是lazy，且线程安全(初始化时dispatch_once) 可以是let 枚举里也可以
struct Shape1 {
    static var count: Int = 0//不存在实例内存中
    static var count1: Int {
        return 10
    }
//    static var count: Int = 0  如果是类也可以用class  
}
//单例
class FileManager {
    //static内部使用swift_once保证只初始化一次，swift_once内部是dispatch_once_f
    public static let shared = FileManager()
    private init() { }
}

//self
//实例方法中代表实例对象
//类型方法中代表类型

//mutating 结构体和枚举，默认情况下不允许在方法中修改属性
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveby(_ xx: Double,_ yy: Double) {
        x += xx
        y += yy
    }
    //@discardableResult消除返回值未使用的警告
    @discardableResult mutating func moveby1(_ xx: Double,_ yy: Double) -> Double {
        x += xx
        y += yy
        return x
    }
}

//下标 subscript给任意类型增加下标功能
//细节 可以没有set,必须要有get  如果只有get,可以省略get
class Point2 {
    var x = 0.0, y = 0.0
    subscript(index: Int) ->Double {//返回值类型决定了，get的返回值，set的newValue
        set {
            if index == 0 {
                x = newValue
            }else if index == 1 {
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            }else if index == 1 {
                return y
            }
            return 0
        }
    }
    //可以是类型方法
    static subscript(v1: Int, v2: Int) -> Int {
        return v1 + v2
    }
    func test() {
        
    }
    class func test1() {
        
    }
}
var p2 = Point2()
p2[0] = 11.1
print(p2[1])

//继承 只有类支持继承
//子类重写父类的 下标、方法、属性 加上override关键字

//内存结构 前16个字节  类型 引用计数

//重写方法
class Point3:Point2 {
    var age = 0
    
    //重写实例方法
    override func test() {
        
    }
    //override 重写下标
    override subscript(index: Int) ->Double {
        set {
        }
        get {
            return 0
        }
    }
    //被class修饰的类型方法可以被子类重写，static不可以  用class和static取决于想不想让子类重写
    override class func test1() {
        
    }
}

//重写属性 子类可以将父类的属性（存储、计算），重写为计算属性
//只能重写var 属性，不能重写let
//子类重写后的权限不能小于父类属性的权限， 比如 父类只读，子类读写
class Point4: Point3 {
    override var age: Int {
        set {
            super.age = newValue
        }
        get {
            return super.age
        }
    }
}
//重写类型属性
//被class修饰的计算类型属性，可以重写
//被static修饰的类型属性（存储，计算），不可以
class Point5 {
    static var age = 1
    var age2 = 2
    class var age1: Int {
        set {
            age = newValue
        }
        get {
            return age
        }
    }
}

//属性观察器
//可以在子类中为父类属性（存储、计算），增加属性观察器，除了只读计算属性、let属性
//如果父类属性已经存在属性观察期，则父类子类的属性观察器都会起作用
class Point6: Point5 {
    override var age2: Int {
        willSet {
            
        }
        didSet {
            print(age2)//这里不会死循环
        }
    }
}

//final 修饰类。不能被继承
//final 修饰方法、属性、下标，不能被重写


//Swift的多态原理
//类似虚表，子类的类型信息内存里，有父类继承下来的函数指针

//初始化器
//类：
//指定初始化器:类至少有一个
//便捷初始化器:必须要调自己类中的指定初始化器
class Size {
    var width: Int = 0
    var height: Int = 0
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    convenience init(width: Int) {
        self.init(width:width, height: 0)//必须放最前面
    }
    convenience init(height: Int) {
        self.init(width: 0,height: height)
    }
}
//子类的指定初始化器，一定要调用直系父类的指定初始化器
//init(width: Int, height: Int) {
//    super.init(width: width)
//    self.height = height
//}

//便捷初始化器也可以调用自己的其他便捷初始化器，但是最终必须要调指定初始化器
//指定初始化器不能调指定初始化器

//两段式初始化
//第一阶段：初始化所有存储属性 由下往上
//第二阶段：设置新的存储属性 由上往下

//安全检查
//指定初始化器要保证自己的属性初始化完，再调用父类的指定初始化器
//指定初始化器必须先调用父类的初始化器，才能为继承的属性设值
//便捷初始化器必须先调用同类的其他初始化器，然后再为任意属性设新值
//初始化器在第一阶段完成前，不能调用任何实例方法、不能读取实例属性，不能引用self

//重写初始化器
//子类可以将父类的指定初始化器重写为 指定初始化器、便捷初始化器 ，必须加上override
//如果子类写了一个匹配父类便捷初始化器的初始化器，不用加上override，严格来讲，子类无法重写父类的便捷初始化器

//自动继承
//如果子类没有写任何指定初始化器，会自动继承父类所有指定初始化器
//如果子类实现了父类所有指定初始化器（继承、重写），会自动继承父类所有便捷初始化器

//required 修饰指定初始化器 希望子类必须实现这个初始化器
class Person {
    required init() {
        
    }
    init(age: Int) {
        
    }
}
class Student: Person {
    //自动继承了
    var name: String
    init(age: Int,name: String) {
        self.name = name
        super.init(age: age)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}

//可失败初始化器

class Man {
//    init?() {
//
//    }
    init!(){
        //可以用init!定义隐式解包的可失败初始化器
        //可失败可以调用可失败，非可失败调用可失败需要解包
        //初始化器调用一个可失败初始化器导致失败了，后面不执行了
        //用一个非可失败 重写 可失败
    }
    deinit {
        //反初始化器
        //类似析构 dealloc
        //没有参数 没有小括号
        //先执行子类的，再执行父类
        //父类的deinit能被子类继承
    }
    
}

//可选链
//如果可选项为nil，调用方法、下标、属性失败，结果为nil
//如果可选项不为nil。调用方法、下标、属性成功，结果会被包装成可选项
//如果结果本来就是可选项，不会进行再次包装

//判断方法有没有调用成功
//if let _ = person?.eat()

//协议
//可以被枚举、结构体、类遵守
//协议中定义方法不能有默认参数值
//默认情况下，协议中定义的内容必须全部实现
protocol Drawable {
    func draw()
    var x: Int { get set } //可以实现为存储属性、计算属性
    var y: Int { get }// 协议中定义属性必须用var,实现的属性权限不可小于协议
    subscript(index: Int) -> Int { get set }
    static func draw1()//为了保持通用，类型方法用static
    mutating func draw2()//设置mutating，才允许结构体、枚举具体实现修改自身变量
    init(x: Int,y: Int)//非final类实现，必须加上required
}

//协议中的 init init? init!
//协议中的init? init! 可以用 init init? init!去实现
//协议中的init 可以用 init init!去实现

//一个协议可以继承另一个协议

//协议组合
//func fn3(obj: Person & Livable & Runnable)
//typealias realPerson = Person & Livable & Runnabl

//CaseIterable 让枚举遵守，可以遍历枚举
//CustomStringConvertible 类似OC的description,自定义打印

//Any AnyObject
//Any:可以代表任意类型（枚举、结构体、类、函数类型）
//AnyObject:可以代表任意类类型
//把AnyObject转换成具体的类型，这⾥我们使⽤三个关键字as，as?，as!进行类型转换
protocol Runnable: AnyObject {//只有类才能遵守这个协议
}

var t1: AnyObject = p //代表类的实例
var t2: AnyObject = Person.self //代表类的类型

var array1 = Array<Any>()//可以放任意类型

//只能被类遵守的协议 3种方式
protocol Runnable3: AnyObject {}
protocol Runnable4: class {}
@objc protocol Runnable5 {} //还能暴露给OC去遵守

//AnyClass
//AnyClass代表了任意实例的类型
//public typealias AnyClass = AnyObject.Type
//所以我们不能用具体的实例对象赋值给AnyClass，编译器会报错。

//可选协议
//第一个方式：给协议增加扩展，扩展里给默认实现
//第二种方式：
@objc protocol Runnable6 {
    @objc optional func run1()
}


//is 、 as? 、as! 、as
//is用来判断是否为某种类型
//as用来做强制类型转换
var stu: Any = 10
print(stu is Int)
stu as? Person

var dd = 10 as Double//百分百可以转的用as就可以

//X.self X.type AnyClass
//X.self 元类型的指针，存放着类型相关信息 X.self属于X.type类型   类似iOS 类对象
//X.type
var p: Person = Person()
var pType: Person.Type = Person.self
//type(Of:)⽤来获取⼀个值的动态类型。
//静态类型(static type)，这个是在编译时期确定的类型。
//动态类型(dynamic Type)，这个是在运⾏时期确定的类型。
pType = type(of: p)//从p取出前8个字节

//self
//T.self: T 是实例对象，当前 T.self 返回的就是实例对象本身。如果 T 是类，当前 T.self 返回的就是元类型。

//Self 一般用作返回值类型，限定返回值跟方法调用者必须是同一类型，也可以作为参数类型
// Self类型不是特定类型，⽽是让您⽅便地引⽤当前类型，⽽⽆需重复或知道该类型的名称。
// 1.在协议声明或协议成员声明中，Self类型是指最终符合协议的类型
protocol MyTestProtocol {
    func get() -> Self //返回遵守协议的类型
}
class MyPerson: MyTestProtocol {
    func get() -> Self {
        self
    }
}
// 2.Self作为实例方法的返回类型代表自身类型
class MyPerson1 {
    func get() -> Self {
        self
    }
}
// 3.计算属性/实例方法中访问自身的类型属性，类型方法
class MyPerson2 {
    static let age = 0
    var age1: Int {
        return Self.age
    }
}

//元类型的使用
var t = Person.self
var p3 = t.init()

//错误处理

struct MyError: Error {
    var msg: String
}

func divide(_ num1: Int,_ num2: Int) throws -> Int {
    if num2 == 0 {
        throw MyError(msg: "除数为0")
    }
    return num1 / num2
}
enum SomeError: Error {
    case illegalArg(String)
    case outOfBounds(Int,Int)
    case outOfMemory
}

var result = try divide(1, 0)//尝试调用
//print(result) 还是系统处理，闪退

//使用do catch

do {
    try divide(20, 0)
    print("1")//一旦抛出异常，这句不执行
} catch let SomeError.illegalArg(msg) {
    print(msg)
} catch SomeError.outOfMemory {
    
} catch let err as SomeError {
    
} catch is SomeError {
    
} catch {
//    error默认有
}
//往上抛
func testError() throws {
    try divide(200, 0)
}

//try? try!
let result1 = try? divide(20, 10) //成功是Int? 失败是nil
let result2 = try! divide(20, 0) //成功是Int 失败nil

//rethrows 函数本身不会抛出错误，但是调用闭包参数抛出错误，那么它会将错误向上抛
func exec1(_ fn:(Int, Int) throws -> Int, _ num1: Int) rethrows {
    try fn(num1,1)
}

//defer 用来定义以任何方式（抛错误\return等）离开代码块前必须执行的代码
func testdefer() {
    defer {
        //延迟到函数结束之前执行
    }
    defer {
        //执行顺序和定义顺序相反，会执行这个
    }
    try? divide(1, 1)
}

//泛型
func swapVal<T>(_ a: inout T,_ b: inout T) {
    (a, b) = (b, a)
}

var fn1: (inout Int,inout Int) -> () = swapVal

func swapVal1<T1,T2>(_ a: inout T1,_ b: inout T2) {
    
}
//泛型方法
func printElement<T: CustomStringConvertible>(_ element: T) {
    print(element)
}
func printElement1<T>(_ element: T) where T: CustomStringConvertible {
    print(element)
}
func printElement2(_ element: some CustomStringConvertible) {
    print(element.description)
}
//返回值使用泛型
func convertToArray<T>(_ element: T) -> [T] {
    return [element]
}
//协议扩展使用泛型
extension Array where Element == String {
    func uppercaseAll() -> [Element] {
        map { $0.uppercased() }
    }
}



class Stack<T> {
    var elements = [T]()
}
//存在继承
class SubStack<T> : Stack<T> {
    
}
struct Stack1<T> {
    var elements = [T]()
    mutating func push(_ elememt: T) {//结构体使用细节
        elements.append(elememt)
    }
}
enum Score<T> {
    case point(T)
    case grade(String)
}
let s = Score.point(1)
//泛型原理：调的是同一个函数，参数里还传了元类型信息

//关联类型：给协议中用到的类定义一个占位名称
//协议想实现泛型，就用关联类型
protocol Stackable {
    associatedtype Element
//    associatedtype Element2
    mutating func push(_ element: Element)
    mutating func pop() -> Element
}
class StringStack : Stackable {
//    typealias Element = String //可以省略
    func push(_ element: String) {
        
    }
    func pop() -> String {
        return ""
    }
}

//类型约束
protocol Stackable1 {
    associatedtype Element : Equatable
}
class Stack2<E : Equatable> : Stackable1 {
    typealias Element = E
}
func equal<S1: Stackable1, S2: Stackable1>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element , S1.Element : Hashable {
    return false
}

//协议类型的注意点
protocol Runnable1 {
    associatedtype Speed
    var speed: Speed { get }
}
class Person1 : Runnable1 {
    var speed: Int { 0 }
}
class Car1 : Runnable1 {
    var speed: Double { 0.1 }
}
//func get123() -> Runnable1 { //报错
//    return Person1()
//}
func get123(_ type: Int) -> some Runnable1 {//不透明类型，想返回某个遵守某协议的对象
//    if type == 1 {  限制只能返回一种类型
//        return Car1()
//    }
    return Person1()
}
//不透明类型还可以用在属性类型上
//var pet: some Runnable1 {
//    return Car1()
//}

//String Array原理
//1、一个字符串，16个字节，15个字节存内容，1个字节分开看，是存储类型和字符串长度
//2、字符串长度超过15，后8个字节 = 字符串真实地址 + 0x7fffffffffffe0（或者 真实地址 = 后8个字节 + 0x20）   常量区__TEXT,__cstring  前8个字节 是存储类型和字符串长度
//3、字面量，就算小于16个字节，在常量区也有
//4、str.append  如果16个字节放的下，还是直接放在变量内存里   放不下，后8个字节 = 字符串真实地址（堆地址） + 0x7fffffffffffe0
//    append内部会申请堆内存空间

//Array原理
//一个Array对象占多少字节？数组中的元素放在哪里？？   8个字节 堆空间地址值
//8 未知？
//16 引用计数
//24 元素数量
//32 数组容量？
//1 元素内容
//...

//可选项的本质 ：enum类型
//用switch判断可选类型
var age2: Int? = 20
switch age2 {
case let v?://如果有值，解包
    print(v)
case nil:
    print("2")
}

//高级运算符
//溢出运算符（&+ &- &*）
var v1 = UInt8.max
var v2 = v1 &+ 1 //0

//运算符重载
struct Point8 {
    var x = 0, y = 0
    
    static func + (p1: Point8, p2: Point8) -> Point8 {
        return Point8(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    //prefix前缀
    static prefix func - (p1: Point8) -> Point8 {
        return Point8(x: -p1.x, y: -p1.y)
    }
    static func += (p1: inout Point8, p2: Point8) {
        p1 = p1 + p2
    }
}
var pp1 = Point8(x: 1, y: 1)
var pp2 = Point8(x: 2, y: 2)

//func + (p1: Point8, p2: Point8) -> Point8 {
//    return Point8(x: p1.x + p2.x, y: p1.y + p2.y)
//}
//前缀

//Equatable 一般要比较两个对象是否相等。实现Equatable协议，重载==
class Person3 : Equatable {
    var age = 0
    static func == (lhs: Person3, rhs: Person3) -> Bool {
        lhs.age == rhs.age
    }
}
//没有关联类型的枚举，自动实现Equatable
//就算有关联类型，如果关联类型遵守了Equatable，协议要写，实现可以不写
//结构体的存储属性全部遵守Equatable，协议要写，实现可以不写

//引用类型 比较地址用恒等于 === !==

//Comparable

//自定义运算符
prefix operator +++
prefix func +++ (_ i: inout Int) {
    i += 2
}
infix operator +- : PlusMinusPrecedence
precedencegroup PlusMinusPrecedence {
    associativity: none //结合性
    higherThan: AdditionPrecedence //比谁优先级高
    lowerThan: MultiplicationPrecedence
    assignment: true //代表在可选链操作中拥有跟赋值运算符一样的优先级
}

//扩展
//为枚举、结构体、类、协议添加新功能
//可以添加方法、计算属性、下标、便捷初始化器、嵌套类型、遵守协议等等
//办不到的事情
//不能覆盖原有的功能
//不能添加存储属性，不能向已有的属性添加属性观察器
//不能添加父类
//不能添加指定初始化器，不能添加反初始化器

//扩展里面可以用原有类中的泛型
//可以给协议扩展方法实现
//可以给协议提供默认实现，间接实现“可选协议”的效果

//符合条件才扩展
//class Stack<T> {
//    var elements = [T]()
//}
extension Stack : Equatable where T : Equatable {
    static func == (lhs: Stack<T>, rhs: Stack<T>) -> Bool {
        lhs.elements == rhs.elements
    }
}

//assert 断言  不能捕捉
//assert(v1 != 0,"除数不能为0")

//fatalError 抛出错误，不可捕捉，release也有效    不得不实现，但是不希望外界使用的时候，也可以用

//访问控制 5个级别
//open:允许定义实体的模块中、其他模块中访问，允许其他模块进行继承、重写（只能用在类、类成员）
//public:允许定义实体的模块中、其他模块中访问.不允许其他模块进行继承、重写
//internal:允许定义实体的模块中,不允许其他模块访问  （绝大部分默认）
//fileprivate:只允许定义实体的模块中
//private:只允许在定义实体的封闭声明中访问

//一个实体不可以被更低访问级别的实体定义，比如person不能被更低级别的Person定义
//元组类型的访问级别是所有成员类型最低的那个
//泛型类型的访问级别是 类型的访问级别 以及 所有泛型类型参数的访问级别 中最低的那个 fileprivate var p = Person<Car, Dog>() Person、Car、Dog中最低
//类型的访问级别会影响成员(属性、方法、初始化器、下标)  并不是直接继承访问级别，而是成员的private和类型的private一样。如果给成员写private就不一样
//private/fileprivate ---> private/fileprivate
//public/internal ---> internal
//getter、setter默认自动接收他们所属环境的访问级别
//可以给setter单独设置一个比getter更低的访问级别，用以限制写的权限 private(set) var age = 0

//如果一个public类想在另一个模块调用编译生成的无参初始化器，必须显式提供public的无参初始化器
//如果结构体有private的存储属性，那么成员初始化器也是private
//枚举不允许给每个case单独设置
//协议里自动继承协议的访问级别 。 协议实现的级别要>= 本身类型的级别、协议方法的级别 两个中最小的
//子类重写父类属性，访问级别要大于本类或者父类属性 两个中最小的

//扩展
//如果有显示设置扩展的访问级别，扩展添加的成员自动接收扩展的访问级别  如果没有写，就跟原来一样
//不能给遵守协议的扩展，添加访问级别
//在原本的声明中声明一个私有成员，可以在同一个文件的扩展中访问他

//内存管理
//弱引用必须是可选类型，必须是var,自动置为nil不会触发属性观察器
//无主引用 unowned类似unsafe_unretained

//weak、unowned的使用限制
//weak、unowned只能用在类实例上面

//Autoreleasepool
autoreleasepool {
    
}

//闭包的循环引用
//闭包表达式默认对外层对象进行retain
//捕获列表
//let p = Person()
//p.fn = {
//    [weak p,unowned wp = p,a = 10 + 20 ](age) in
//    p?.run()
//}

//如果lazy属性是闭包调用的结果，就不用考虑循环引用的(因为闭包调用后，闭包的生命周期就结束了)
//lazy var getAge: Int {
//    self.age
//}()

//@escaping
//非逃逸闭包：闭包调用在函数返回前
//逃逸闭包：闭包有可能在函数结束后调用，需要用@escaping
//逃逸闭包不可捕获inout参数

//局部作用域
//do {
//    var a = 1
//}

//内存访问冲突
//满足两个条件：
//1.至少一个是写才做
//2.访问同一块内存
//3.访问时间重叠

//指针
//UnsafePointer<Pointee> 类似 const Pointee *
//UnsafeMutablePointer<Pointee> 类似 Pointee *  可以访问内存。也可以修改内存
//UnsafeRawPointer 类似 const void *
//UnsafeMutableRawPointer 类似 void *

var age = 10
func test1(_ ptr: UnsafeMutablePointer<Int>) {
    ptr.pointee = 20//修改
}
func test2(_ ptr: UnsafePointer<Int>) {
    print(ptr.pointee)//取出
}
func test3(_ ptr: UnsafeRawPointer) {
    var a = ptr.load(as: Int.self)//取出
}
func test4(_ ptr: UnsafeMutableRawPointer) {
    ptr.storeBytes(of: 30, as: Int.self)//写入
}
test1(&age)
test2(&age)

var arr333 = NSArray(objects: 11,22)
arr333.enumerateObjects { (element, idx, stop) in
    stop.pointee = true
}

for (idx,element) in arr.enumerated() {
    break
}

//获得某个变量的指针
var ptr1 = withUnsafePointer(to: &age) { $0 }
var ptr2 = withUnsafeMutablePointer(to: &age) { $0 }
var ptr3 = withUnsafePointer(to: &age) { (p) -> Int in
    return 20   //这个闭包返回什么，ptr3就是什么
}
var ptr4 = withUnsafePointer(to: &age) {
    return UnsafeRawPointer($0)
}

//修改指针内容
//1
age = withUnsafePointer(to: &age, { ptr in
    return ptr.pointee + 1
})
//2
withUnsafeMutablePointer(to: &age) { ptr in
    return ptr.pointee + 1
}

//获得指向堆空间实例的指针
var person = Person(age: 21)
var ptr5 = withUnsafePointer(to: &person) { UnsafeRawPointer($0)}
var personAddress = ptr5.load(as: UInt.self)
var ptr6 = UnsafeMutableRawPointer(bitPattern: personAddress)

//创建指针
var ptr7 = malloc(16)
ptr7?.storeBytes(of: 10, as: Int.self)
ptr7?.storeBytes(of: 20, toByteOffset: 8, as: Int.self)
ptr7?.load(as: Int.self)
//fromByteOffset: 读取数据偏移大小
//as:数据类型
ptr7?.load(fromByteOffset: 8, as: Int.self)
free(ptr7)
///byteCount:需要多少内存空间
///alignment:内存对齐大小
var ptr8 = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
//of:数据大小
//as:数据类型
ptr8.storeBytes(of: 11, as: Int.self)
//by: 可以移动的步长
var ptr9 = ptr8.advanced(by: 8)//返回指向后8个字节的指针
ptr8.deallocate()

var ptr10 = UnsafeMutablePointer<Int>.allocate(capacity: 3)
ptr10.initialize(to: 10)//初始化前8个字节
ptr10.initialize(repeating: 10, count: 2)//初始化16个字节
ptr10.pointee = 10
ptr10.successor()//后继 指向下一个Int
print((ptr10 + 1).pointee)
print(ptr10[0])

ptr10.deinitialize(count: 3)//不写会内存泄漏
ptr10.deallocate()

//在Swift中提供了三种不同的API来绑定指针，或者重新绑定指针
//使⽤ assumingMemoryBound(to:) 来告诉编译器预期的类型
//RawPointer转Pointer
ptr8.assumingMemoryBound(to: Int.self)
(ptr8 + 8).assumingMemoryBound(to: Int.self)

func testPointer(_ p: UnsafePointer<Int>) {
    print(p[0])
    print(p[1])
}
let myTuple = (10,20)
withUnsafePointer(to: myTuple) { tuplePtr in
    //先转到原生指针
    let ptr = UnsafeRawPointer(tuplePtr)
    //绑定类型
    testPointer(ptr.assumingMemoryBound(to: Int.self))
}
//bindMemory(to: capacity:)
//⽤于更改内存绑定的类型，如果当前内存还没有类型绑定，则将⾸次绑定为该类型；否则重新绑定该类型，并且内存中所有的值都会变成该类型。
withUnsafePointer(to: myTuple) { tuplePtr in
    //先转到原生指针
    let ptr = UnsafeRawPointer(tuplePtr)
    //绑定类型
//    testPointer(ptr.assumingMemoryBound(to: Int.self))
    testPointer(ptr.bindMemory(to: Int.self, capacity: 1))
}

//withMemoryRebound(to: capacity: body:)
//来临时更改内存绑定类型.当离开当前的作用域就会失效，重新绑定为原始类型。
let Uint8ptr = UnsafePointer<UInt8>.init(bitPattern: 10)
Uint8ptr?.withMemoryRebound(to: Int.self, capacity: 1, { intptr in
    testPointer(intptr)
})


var ptr11 = unsafeBitCast(ptr8, to: UnsafeMutablePointer<Int>.self)




//字面量
extension Int : ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = value ? 1 : 0
    }
}
//ExpressibleByArrayLiteral
//ExpressibleByDictionaryLiteral

//模式
//_ 匹配任何值
//_? 匹配非nil值
enum Life {
    case human(name: String, age: Int?)
    case animal(name: String, age: Int?)
}
func check(_ life: Life) {
    switch life {
    case .human(let name, _):
        print(name)
    case .animal(let name, _?):
        print(name)
    case .human(_ as String, _?):
        print("")
    default:
        print("other")
    }
}

//if case 等价于只有一个case的switch
var num20 = 1
if case 0...9 = age {
}
//guard case 0...9 = age else {
//}

let ages: [Int?] = [2, 3, nil, 5]
for case nil in ages {
    print("有nil")
}

let points = [(1, 0),(2, 1)]
for case let (x, 0) in points {
    
}

//可选模式
var age20: Int? = 42
if case .some(let x) = age20 { print(x) }
if case let x? = age20 { print(x) }
func check1(_ num: Int?) {
    switch num {
    case 2?:
        print("2")
    default:
        print("other")
    }
}

//类型转换模式
let num21: Any = 6
switch num21 {
case is Int:
    print("is Int")
case let num22 as Double:
    print(num22)
default:
    break
}

//表达式模式 主要用在case
//重载 ~=


//where
//switch、for循环、协议关联类型、函数泛型、扩展

// MARK: 类似#pragma mark
// MARK:- <#name#>  类似#pragma mark -
// TODO: 用于标记未完成的任务
// FIXME: 用于标记待修复的问题

#warning("todo")

func zhanwei() -> Person {
    fatalError()
}

//条件编译
#if os(macOS) || os(iOS)

#elseif arch(x86_64) || arch(arm64)

#elseif swift(<5) && swift(>=3)

#elseif targetEnvironment(simulator)

#elseif canImport(Foundation)

#else
#endif

print(#file,#line,#function)


if #available(iOS 10, *) {
    
}

@available(iOS 10, *)
class Person11 {
    @available(*,unavailable,renamed: "study")
    func study_() {
        
    }
    func study() {
        
    }
    @available(iOS, deprecated: 11)
    func run() {
    }
}

//程序入口
//@UIApplicationMain 自动设AppDeleagete为代理
//也可以自己建 main.swift

//Swift Runtime
//纯swift类没有动态性，但在⽅法、属性前添加dynamic修饰，可获得动态性。
//继承⾃NSObject的swift类，其继承⾃⽗类的⽅法具有动态性，其它⾃定义⽅法、属性想要获得动态性，需要添加dynamic修饰。
//若⽅法的参数、属性类型为swift特有、⽆法映射到objective－c的类型(如Character、Tuple)，则 此⽅法、属性⽆法添加dynamic修饰(编译器报错)

//swift 调用 OC
//新建桥接头文件  {TargetName}-Bridging-Header.h   (创建一个OC文件，会提示是否创建)
//OC里面哪些要暴露给swift的头文件

//如果C语言暴露的函数名和swift函数名冲突了,会优先调用swift
//可以在swfit中使用 @_silgen_name 修改C函数名
//@_silgen_name("sum") func swift_sum() {
//
//}
//可以使用这种方式去调系统函数

//OC 调用 swift
//头文件  {targetName}-Swift.h


//可以用通过@objc 重命名Swift暴露给OC的符号名（类名、属性名、函数名等）
//@objc(MJMyCar)
//@objcMembers class MyCar: NSObject {
//    @objc(exec:v2:)
//    func test() {
//
//    }
//}

//选择器
//#selector(name)  #selector(run)   必须是被@objc修饰的
func run() {
//    perform(@selector(test1))
//    perform(@selector(test1(v1:)))
//    perform(@selector(test1(_:_:)))
//    perform(@selector(test1 as (Double, Double) -> Void))
}

//1.为什么Swift暴露给OC的类最终要继承自NSObject?
//需要isa指针 需要消息机制

//2.OC的类Person p.run()底层是怎么调用的？反过来，OC调用Swift底层是如何调用？
//OC暴露给swift走的还是消息发送机制    反过来也是消息发送

//3.虽然是@objcMembers，但仍然在swift里调
//走的虚表

//4.强制希望走消息发送机制
//@objc dynamic func run()

//String
var str1 = "1_2"
str1.append("_3")
str1.insert("_", at: str1.endIndex)
str1.insert(contentsOf: "666", at: str.index(after: str.startIndex))

str1.remove(at: str1.firstIndex(of: "_")!)
str1.removeAll { $0 == "6"}
//Substring 与它的base共享字符串数据，发生修改时或转为String时，会分配新的内存存储字符串数据
var str2 = str1.prefix(3)
str2.base

//拼接
["A","B"].joined(separator: ",")

//多行字符串
var str3 = """
s1
  w2
"""//以后一个"""对齐

//String 和 NSSring
var str4 = str3 as NSString
var str5 = str4 as String

//String比较 ==
//String和NSString无缝桥接，String不能桥接转换成NSMutableString 

//swift支持KVC/KVO,要求属性所在类，监听器 要继承自NSObject,用@objc dynamic修饰属性

//block方式的KVO
class Person6: NSObject {
    @objc dynamic var age6: Int = 0
    var observation: NSKeyValueObservation?
    override init() {
        super.init()
        observation = observe(\Person6.age6, options: .new, changeHandler: { (person, change) in
            print(change.newValue)
        })
    }
}

//关联对象 ,class依然可以
//默认情况extension,不能添加存储属性

class Person7 {
    
}
extension Person7 {
    private static var AGE_KEY: Void?//只占一个字节
    var age: Int {
        get {
            objc_getAssociatedObject(self, &Self.AGE_KEY) as! Int
        }
        set {
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

//资源名管理 第三方库 R SwiftGen
enum R {
    enum string: String {
        case add = "添加"
    }
    enum image: String {
        case logo //没有值，默认一样
    }
}

//多线程
DispatchQueue.global().async {
    
}

let item = DispatchWorkItem {
  print("1")
}
DispatchQueue.global().async(execute: item)
item.notify(queue: DispatchQueue.main) {
    print("异步完成后，切回主线程")
}
item.cancel()//封装成item，可以取消

//延迟
let time = DispatchTime.now() + 3
DispatchQueue.main.asyncAfter(deadline: time) {
    
}

//once
//static var age123: Int = {
//    return 0
//}()

//锁
//信号量
//var lock = DispatchSemaphore(value: 1)
//lock.wait()//加锁
//lock.signal()

//var lock = NSLock()
//var lock = NSRecursiveLock()

//数组常见操作
var arr123 = [1, 2, 3, 4]
var arr2 = arr123.reduce(0) { (result, element) -> Int in
    return result + element //result从初始值开始，第二次result是上一次的返回值
}//累加结果

//reduce(into: []) { partialResult, request in
//        partialResult.append(request) // 把4个请求收集到数组中
//      }

//[1,2,2,3,3,3]
//arr123.flatMap { (Int) -> Sequence in
//
//}
//如果是nil就过滤
//arr123.compactMap { (Int) -> ElementOfResult? in
//
//}
// 取出httpBody属性
//    .compactMap(\.httpBody)

    
//lazy的优化
//let result = arr123.lazy.map { (Int) -> T in
//
//}

//Optional的map和flatMap
var num111: Int? = 10
var num222 = num111.map { $0 * 2 }//Optional(20)
var num333: Int? = nil
var num444 = num333.map { $0 * 2 }//nil
var num555 = num111.map {Optional.some($0 * 2)}//Optional(Optional(20))
var num666 = num111.flatMap { Optional.some($0 * 2) }//Optional(20)

//利用协议实现前缀效果


//利用协议来实现类型判断
func isArray(_ value: Any) -> Bool {
    value is [Any]
}

protocol ArrayType{}
extension Array: ArrayType {}
extension NSArray: ArrayType {}
func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}


//TypeMetadata 看源码

//反射 Mirror
let mirror = Mirror(reflecting: Person(age: 10))
print(mirror.displayStyle)
print(mirror.subjectType)
print(mirror.superclassMirror as Any)
//通过 label 输出当前的名称，value 输出当前反射的值
for case let (label?, value) in mirror.children {
    print(label, value)
}
//这里通过遵循customReflectable 协议并实现了其中的计算属性customMirror，主要作用是当我们使用lldb debug的时候，可以提供详细的属性信息。
class Girl: CustomReflectable {
    var age: Int = 18
    var name: String = "GG"
    
    var customMirror: Mirror {
        let info = KeyValuePairs<String,Any>.init(dictionaryLiteral: ("age",age),("name",name))
        let mirror = Mirror(self, children: info, displayStyle: .class, ancestorRepresentation: .generated)
        return mirror
    }
}


//convention  https://www.jianshu.com/p/f4dd6397ae86
//用来修饰闭包的。他后面需要跟一个参数：
//@convention(swift) : 表明这个是一个swift的闭包
//@convention(block) ：表明这个是一个兼容oc的block的闭包
//@convention(c) : 表明这个是兼容c的函数指针的闭包。
class PersonObj:NSObject {

    func doAction(action: @convention(swift) (String)->Void, arg:String){
        action(arg)
    }
}

let saySomething_c : @convention(c) (String)->Void = {
    print("i said: \($0)")
}

let saySomething_oc : @convention(block) (String)->Void = {
    print("i said: \($0)")
}

let saySomething_swift : @convention(swift) (String)->Void = {
    print("i said: \($0)")
}

let personobj = PersonObj()
personobj.doAction(action: saySomething_c, arg: "helloworld")
personobj.doAction(action: saySomething_oc, arg: "helloworld")
personobj.doAction(action: saySomething_swift, arg: "helloworld")

// 使用场景
class PersonObject:NSObject {
    //数  数字
    @objc dynamic func countNumber(toValue:Int){
        for value in 0...toValue{
            print(value)
        }
    }
}
//现在我们要替换数数函数的实现，给他之前和之后加上点广告语。

//拿到method
let methond = class_getInstanceMethod(Person.self, #selector(PersonObject.countNumber(toValue:)))
//通过method拿到imp， imp实际上就是一个函数指针
let oldImp = method_getImplementation(methond!)
//由于IMP是函数指针，所以接收时需要指定@convention(c)
typealias Imp  = @convention(c) (PersonObject,Selector,NSNumber)->Void
//将函数指针强转为兼容函数指针的闭包
let oldImpBlock = unsafeBitCast(oldImp, to: Imp.self)

//imp_implementationWithBlock的参数需要的是一个oc的block，所以需要指定convention(block)
let newFunc:@convention(block) (PersonObject, NSNumber)->Void = {
    (sself,  toValue) in
    print("数之前， 祝大家新年快乐")
    oldImpBlock(sself, #selector(PersonObject.countNumber(toValue:)), toValue)
    print("数之后， 祝大家新年快乐")
}
let imp = imp_implementationWithBlock(unsafeBitCast(newFunc, to: AnyObject.self))
method_setImplementation(methond!, imp)
let person123 = PersonObject()
person123.countNumber(toValue: 50)


// https://zxfcumtcs.github.io/2022/02/01/SwiftProtocol1/
// 协议类型擦除   把实现协议的多个类型，放到同一个数组里

public protocol MarkdownBuilder: Equatable, Identifiable {
  var style: String { get }
  func build(from text: String) -> String
}
extension MarkdownBuilder {
  public var id: String { style }
}
// 斜体
//
fileprivate struct ItalicsBuilder: MarkdownBuilder {
  public var style: String { "*Italics*" }
  public func build(from text: String) -> String { "*\(text)*" }
}

// 粗体
//
fileprivate struct BoldBuilder: MarkdownBuilder {
  public var style: String { "**Bold**" }
  public func build(from text: String) -> String { "**\(text)**" }
}

//private let allBuilders: [MarkdownBuilder]  //Protocol 'MarkdownBuilder' can only be used as a generic constraint because it has Self or associated type requirements
//解决
public struct AnyBuilder: MarkdownBuilder {
  public let style: String
  public var id: String { "AnyBuilder-\(style)" }

  private let wrappedApply: (String) -> String

  public init<B: MarkdownBuilder>(_ builder: B) {
    style = builder.style
    wrappedApply = builder.build(from:)
  }
  public func build(from text: String) -> String {
    wrappedApply(text)
  }
  public static func == (lhs: AnyBuilder, rhs: AnyBuilder) -> Bool {
    lhs.id == rhs.id
  }
}
// 使用
private let allBuilders: [AnyBuilder]

// 扩展
public extension MarkdownBuilder {
  func asAnyBuilder() -> AnyBuilder {
    AnyBuilder(self)
  }
}
BoldBuilder().asAnyBuilder()
AnyBuilder(BoldBuilder())

// ⚠️ 更方便的类型擦除 使用any
//private let allBuilders1: [any MarkdownBuilder]
//allBuilders1.append(BoldBuilder())

func getBuilder() -> some MarkdownBuilder {
    return BoldBuilder()
}

func getBulder1() -> any MarkdownBuilder {
    return BoldBuilder()
}


// 理解 any some  https://swiftsenpai.com/swift/understanding-some-and-any/

protocol Vehicle {

    var name: String { get }

    associatedtype FuelType
    func fillGasTank(with fuel: FuelType)
}

struct Car: Vehicle {

    let name = "car"

    func fillGasTank(with fuel: Gasoline) {
        print("Fill \(name) with \(fuel.name)")
    }
}

struct Bus: Vehicle {

    let name = "bus"

    func fillGasTank(with fuel: Diesel) {
        print("Fill \(name) with \(fuel.name)")
    }
}

struct Gasoline {
    let name = "gasoline"
}

struct Diesel {
    let name = "diesel"
}

// 1 some 作为函数参数时，这三个函数签名一样

func wash<T: Vehicle>(_ vehicle: T) {
    // Wash the given vehicle
}
func wash1<T>(_ vehicle: T) where T: Vehicle {
    // Wash the given vehicle
}
func wash2(_ vehicle: some Vehicle)  {
    // Wash the given vehicle
}
// 2 some 作为变量类型时,具体类型在编译期就固定了
var myCar: some Vehicle = Car()
//myCar = Bus() // 🔴 Compile error: Cannot assign value of type 'Bus' to type 'some Vehicle'
// 赋值同类型也报错
var myCar1: some Vehicle = Car()
var myCar2: some Vehicle = Car()
//myCar2 = myCar1 // 🔴 Compile error: Cannot assign value of type 'some Vehicle' (type of 'myCar1') to type 'some Vehicle' (type of 'myCar2')
// ✅ No compile error
let vehicles: [some Vehicle] = [
    Car(),
    Car(),
    Car(),
]

// 🔴 Compile error: Cannot convert value of type 'Bus' to expected element type 'Car'
//let vehicles: [some Vehicle] = [
//    Car(),
//    Car(),
//    Bus(),
//]

// 3 some 作为函数返回值时
// ✅ No compile error
func createSomeVehicle() -> some Vehicle {
    return Car()
}

// 🔴 Compile error: Function declares an opaque return type 'some Vehicle', but the return statements in its body do not have matching underlying types
//func createSomeVehicle(isPublicTransport: Bool) -> some Vehicle {
//    if isPublicTransport {
//        return Bus()
//    } else {
//        return Car()
//    }
//}

// any 在5.7中不能省略的场景
// any 用于表示包装类型，表示遵循某个协议的Box

//let myCar33: Vehicle = Car() // 🔴 Compile error in Swift 5.7: Use of protocol 'Vehicle' as a type must be written 'any Vehicle'
let myCar44: any Vehicle = Car() // ✅ No compile error in Swift 5.7

// 🔴 Compile error in Swift 5.7: Use of protocol 'Vehicle' as a type must be written 'any Vehicle'
//func wash(_ vehicle: Vehicle)  {
//    // Wash the given vehicle
//}

// ✅ No compile error in Swift 5.7
func wash3(_ vehicle: any Vehicle)  {
    // Wash the given vehicle
}
// 因为是包装类型，所以不会报错
// ✅ No compile error when changing the underlying data type
var myCar55: any Vehicle = Car()
myCar55 = Bus()
myCar55 = Car()

// ✅ No compile error when returning different kind of concrete type
func createAnyVehicle(isPublicTransport: Bool) -> any Vehicle {
    if isPublicTransport {
        return Bus()
    } else {
        return Car()
    }
}

// 🔴 Compile error in Swift 5.6: protocol 'Vehicle' can only be used as a generic constraint because it has Self or associated type requirements
// ✅ No compile error in Swift 5.7
let vehicles1: [any Vehicle] = [
    Car(),
    Car(),
    Bus(),
]

// any的主要限制在于，不能使用==进行比较
//如果你仔细想想，这实际上是有道理的。如前所述，存在类型可以在其“盒子”中存储任何具体类型。对于编译器来说，存在类型只是一个“盒子”，它不知道盒子里是什么。因此，当编译器不能保证“box”的内容具有相同的底层具体类型时，它不可能进行比较。
let myCar7 = createAnyVehicle(isPublicTransport: false)
let myCar8 = createAnyVehicle(isPublicTransport: false)
//let isSameVehicle = myCar7 == myCar8 // 🔴 Compile error: Binary operator '==' cannot be applied to two 'any Vehicle' operands

let myCar9 = createSomeVehicle()
let myCar10 = createSomeVehicle()
//let isSameVehicle = myCar9 == myCar10 // ✅ No compile error   这里有疑问❓ Binary operator '==' cannot be applied to two 'some Vehicle' operands


//some & any 比较
//最后，我们来讨论一下 some 与 any 的区别，以及在不同场景下该如何选择。
//some 会固定其修饰的类型，调用时可以完整访问到其遵循协议的方法与协议的关联类型。
//any 会进行类型擦除，可以用来存储不同元素类型的集合。
// 在通常情况下，可以直接使用 some 来修饰类型，除非需要表示任意类型时，再换成 any 即可。

// any some 实现动态派发 https://swiftsenpai.com/swift/dynamic-dispatch-with-generic-protocols/

// any some 使用区别
protocol Pizza {
    var size: Int { get }
    var name: String { get }
}

func receivePizza(_ pizza: Pizza) {//性能不佳，运行时需要拆箱
    print("Omnomnom, that's a nice \(pizza.name)")
}

func receivePizza1<T: Pizza>(_ pizza: T) {//区别在于，编译期就知道具体类型
    print("Omnomnom, that's a nice \(pizza.name)")
}

func receivePizza2(_ pizza: any Pizza) {//更为方便
    print("Omnomnom, that's a nice \(pizza.name)")
}

//let someCollection: Collection 报错 Use of protocol 'Collection' as a type must be written 'any Collection'
let someCollection: some Collection = [] //Property declares an opaque return type, but has no initializer expression from which to infer an underlying type
//let someCollection: any Collection

func receivePizza3(_ pizza: some Pizza) {//some关键字还允许编译器在编译时知道some对象的底层类型
    print("Omnomnom, that's a nice \(pizza.name)")
}

//any 需要运行时拆箱  some和泛型则在编译期就知道具体类型
class MusicPlayer { //支持开始时是数组，但是传给play一个set
//    var playlist: some Collection<String> = [] //2个地方不能推断
    var playlist: any Collection<String> = []

    func play(_ playlist: some Collection<String>) {
        self.playlist = playlist
    }
}

//class MusicPlayer1<T: Collection<String>> { //强制2个地方用一样的类型
//    var playlist: T = []
//
//    func play(_ playlist: T) {
//        self.playlist = playlist
//    }
//}

//Opaque Types 就是让函数/方法的返回值是协议，而不是具体的类型。
//只想对外暴露MarkdownBuilder
//public func italicsBuilder() -> MarkdownBuilder {   Protocol 'MarkdownBuilder' can only be used as a generic constraint because it has Self or associated type requirements
//  ItalicsBuilder()
//}

//解决
public func italicsBuilder() -> some MarkdownBuilder {
    ItalicsBuilder()
}
//Opaque Types 与直接返回协议类型的最大区别是：
//Opaque Types 只是对使用方(人)隐藏了具体类型细节，编译器是知道具体类型的；
//而直接返回协议类型，则是运行时行为，编译器是无法知道的；
//编译器是明确知道 italicsBuilder 方法的返回值类型是 ItalicsBuilder，但方法调用方却只知道返回值遵守了 MarkdownBuilder 协议。从而也就达到了隐藏实现细节的目的；

// Swift 中的幻象类型:https://mp.weixin.qq.com/s?__biz=MzAxNzgzNTgwMw==&mid=2247488350&idx=1&sn=6f6a8f3842a8957f0233e3c618a758c7&scene=21#wechat_redirect
//Phantom Types   用于对类型做进一步的强化。
//Phantom Types 没有严格的定义，一般表述是：出现在泛型参数中，但没有被真正使用。
//如下代码中的 Role (例子来自 How to use phantom types in Swift)，它只出现在泛型参数中，在 Employee 实现中并未使用：
struct Employee<Role>: Equatable {
    var name: String
}
enum Sales { }
enum Programmer { }
//由于 Employee 实现了 Equatable，可以在两个实例间进行判等操作。
//但判等操作明显只有在同一种角色间进行才有意义：
let john = Employee<Sales>.init(name: "John")
let sea = Employee<Programmer>.init(name: "Sea")
//john == sea  //Cannot convert value of type 'Employee<Programmer>' to expected argument type 'Employee<Sales>'
