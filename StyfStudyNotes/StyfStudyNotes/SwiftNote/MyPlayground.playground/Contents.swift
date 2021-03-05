import UIKit

var str = "Hello, playground"

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

class FileManager {
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
protocol Runnable: AnyObject {//只有类才能遵守这个协议
}
var array1 = Array<Any>()//可以放任意类型

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
pType = type(of: p)//从p取出前8个字节

//元类型的使用
var t = Person.self
var p3 = t.init()

//Self 一般用作返回值类型，限定返回值跟方法调用者必须是同一类型，也可以作为参数类型

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

//一个实体不可以被更低访问级别的实体定义，比如




