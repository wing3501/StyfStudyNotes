//
//  ContentView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/20.
//

import SwiftUI

struct Person {
    var name: String
    var age: Int
}

class Student: ObservableObject {
    @Published var name: String = ""
    @Published var age: Int = 0
}

struct ContentView: View {
//    @State 修饰的值，在 SwiftUI 内部会被自动转换为一对 setter 和 getter，对这个属性进行赋值的操作将会触发 View 的刷新，
//    它的 body 会 被再次调用，底层渲染引擎会找出界面上被改变的部分，根据新的属性值计算出新 的 View，并进行刷新。
//    对于 @State 修饰的属性的访问，只能发生在 body 或者 body 所调 用的方法中。
    @State private var brain: CalculatorBrain = .left("0")
//    使用 @ObservedObject 将它和 ContentView 关联起来。当 CalculatorModel 中的 objectWillChange 发出事件时，body 会被调用，UI 将被刷新。
    @ObservedObject var model = CalculatorModel()
    
//    @State private var p: Person = Person(name: "jack", age: 10)
    
    @State private var editingHistory = false
    
//    在 SwiftUI 中，View 提供了 environmentObject(_:) 方法，来 把某个 ObservableObject 的值注入到当前 View 层级及其子层级中去。在这个 View 的子层级中，可以使用 @EnvironmentObject 来直接获取这个绑定的环境值。
//    let vc = UIHostingController(rootView: ContentView().environmentObject(Student()))
    @EnvironmentObject var student: Student
    
    //✅ 使用建议
//    1 在此之前，如果你纠结于选择使用哪种方式的话，从 ObservableObject 开始入手会是一个相对好的选择:
//    2 如果发现状态可以被限制在同一个 View 层级中， 则改用 @State;
//    3 如果发现状态需要大批量共享，则改用 @EnvironmentObject。
    
    //alert练习
    @State private var showAlert = false
    
    var body: some View {
//        let scale: CGFloat = UIScreen.main.bounds.width / 414
        VStack(spacing: 12) {
            Spacer()
            Spacer()
            Button("操作履历: \(model.history.count)") {
                self.editingHistory = true
            }.sheet(isPresented: self.$editingHistory) {
//                .sheet 调用将会在它的 isPresented 为 true 的时候以 modal 的方式展示一个在尾 随闭包中定义的 View (这里就是 HistoryView)。
                HistoryView(model: self.model)
            }
            Button("alert弹窗") {
                showAlert = true
            }
//            .alert("标题", isPresented: $showAlert) {
//                Text("额。。。。。")
//            }
            .alert("标题", isPresented: $showAlert) {
                Button("按钮1") {
                    UIPasteboard.general.string = "123456"
                }
                Button("按钮2") {}
            } message: {
                Text("这是信息")
            }


            
//            Text(brain.output)
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)//字体自适应缩放因子   允许 Text (在文本无法适配尺寸时) 以更小的字号进行渲染。
                .padding(.trailing,24)//右边距
                .lineLimit(1)//限制1行
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)//填满一行
//            Text(p.name)
//            Button("测试") {
//                p.name = "Tom" //OK
//                p = Person(name: "JoJo", age: 11) //OK
//                self.brain = .left("1.23")
//            }
            //在这里，你只需要知道 $brain 的写法将 brain 从 State 转换成了引用语义的 Binding，并向下传递
            //这样一来，底层 CalculatorButtonRow 中对 brain 的修改，将反过来影响和设置最顶层 ContentView 中的 @State brain。
//            CalculatorButtonPad(brain: $brain)
//            CalculatorButtonPad(brain: $model.brain)
            CalculatorButtonPad(model: model)
                .padding(.bottom)
        }
//        .scaleEffect(scale) //粗暴适配，整个页面缩放
        
        
//        VStack(alignment: .trailing, spacing: 8) {//每个元素的间距为 8
//            CalculatorButtonRow(row: [
//                .command(.clear),.command(.flip),.command(.percent),.op(.divide)
//              ])
//            CalculatorButtonRow(row: [
//                .digit(7), .digit(8), .digit(9), .op(.multiply)
//              ])
//            CalculatorButtonRow(row: [
//                .digit(4), .digit(5), .digit(6), .op(.minus)
//              ])
//            CalculatorButtonRow(row: [
//                .digit(1), .digit(2), .digit(3), .op(.plus)
//              ])
//            CalculatorButtonRow(row: [
//                .digit(0), .dot,.op(.equal)
//              ])
//        }
        
        
        
        
//        HStack{
//            CalculatorButton(title: "1", size: CGSize(width: 88, height: 88), backgroundColorName: "myGrayColor") {
//                print("button 1")
//            }
//            CalculatorButton(title: "2", size: CGSize(width: 88, height: 88), backgroundColorName: "myGrayColor") {
//                print("button 2")
//            }
//            CalculatorButton(title: "3", size: CGSize(width: 88, height: 88), backgroundColorName: "myGrayColor") {
//                print("button 3")
//            }
//            CalculatorButton(title: "+", size: CGSize(width: 88, height: 88), backgroundColorName: "myOrangeColor") {
//                print("button +")
//            }
//        }
    }
}

struct CalculatorButtonPad: View {
    //    @Binding 也是对属性的修 饰，它做的事情是将值语义的属性 “转换” 为引用语义。
    //    对被声明为 @Binding 的属 性进行赋值，改变的将不是属性本身，而是它的引用，这个改变将被向外传递。
//    @Binding var brain: CalculatorBrain
    var model: CalculatorModel
    
    let pad: [[CalculatorButtonItem]] = [ [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
                                          [.digit(7), .digit(8), .digit(9), .op(.multiply)],
                                          [.digit(4), .digit(5), .digit(6), .op(.minus)],
                                          [.digit(1), .digit(2), .digit(3), .op(.plus)],
                                          [.digit(0), .dot, .op(.equal)]
                                      ]
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {//每个元素的间距为 8
            ForEach(pad, id: \.self) { row in
//                CalculatorButtonRow(brain: $brain, row: row)
                CalculatorButtonRow(model: model, row: row)
            }
        }
    }
}


struct CalculatorButtonRow : View {
    
//    @Binding var brain: CalculatorBrain
    var model: CalculatorModel
    
    @EnvironmentObject var student: Student
    
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack {
            //使用 ForEach(_:id:) 来通过某个支持 Hashable 的 key path 获取一个等效的元素是 Identifiable 的数组
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
//                    brain = brain.apply(item: item)
                    model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButton : View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height, alignment: .center)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
                
        }
    }
}

struct TestView1 : View {
    var body: some View {
        Button {
            print("点击了")
        } label: {
            Text("+")
                //字体大小
    //            .font(.title)
    //            .font(.system(size: 48))
                .font(.custom("Copperplate", size: 48))
                //字体颜色
    //            .foregroundColor(.white)
                .foregroundColor(Color(red: 111, green: 111, blue: 111))
                //内边距
    //            .padding()
    //            .padding(.top,16)
    //            .padding(.horizontal,8)
                //布局
                .frame(width: 88, height: 88, alignment: .center)
                //背景
    //            .background(.red)
                .background(Color("myOrangeColor"))
                //圆角
                .cornerRadius(44)
                //顺序对结果的影响
    //            .background(.orange)
    //            .padding()
    //            .background(.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //多屏幕预览
        //ContentView().previewDevice("iPhone 8")
    }
}
