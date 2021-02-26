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
        //属性观察期 也可以用在全局变量、局部变量
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
