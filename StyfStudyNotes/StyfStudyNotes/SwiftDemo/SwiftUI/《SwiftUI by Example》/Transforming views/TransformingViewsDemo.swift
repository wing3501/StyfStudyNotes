//
//  TransformingViewsDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/18.
//

import SwiftUI

struct TransformingViewsDemo: View {
    var body: some View {
        ScrollView {
            Group {
                //使用PToggleStyle自定义开关样式
                UsingToggleStyleCustomizingToggle()
                //使用ProgressViewStyle自定义进度条样式
                UsingProgressViewStyleCustomizingProgressView()
                //使用ButtonStyle自定义按钮样式，为了复用，有系统预设的
                UsingButtonStyleCustomizingButton()
            }
            
            Group {
                //调整视图的亮度、色调、色调、饱和度等
                AdjustViewsTintingMore()
                //图层混合模式
                BlendViews()
                //模糊视图
                BlurAnView()
                //使用蒙版
                MaskOneView()
                //调整顶层访问颜色
                AdjustAccentColor()
                //调整透明度
                AdjustOpacity()
                //给视图加圆角
                RoundCorners()
            }
            Group {
                //缩放视图
                ScaleAView()
                //3D旋转视图
                RotateAView3D()
                //旋转视图
                RotateAView()
                //裁剪视图
                ClipAView()
                //绘制阴影
                DrawShadow()
                //虚线边框
                MarchingAntsBorder()
                //View内部画边框
                DrawBorderInside()
                //View外部画边框
                DrawBorderAround()
                //modifier叠加使用，产生不同的效果
                MoreModifier()
                //使用Offset调整 位置
                UsingOffset()
            }
        }
    }
}

//-----------------------------
struct UsingToggleStyleCustomizingToggle : View {
    @State private var isOn = false
    var body: some View {
        TestWrap("使用PToggleStyle自定义开关样式") {
            VStack {
                Toggle("Switch Me", isOn: $isOn)
                    .toggleStyle(CheckToggleStyle())
            }
        }
    }
}

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(configuration.isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
//-----------------------------
struct UsingProgressViewStyleCustomizingProgressView : View {
    @State private var progress = 0.2
    var body: some View {
        TestWrap("使用ProgressViewStyle自定义进度条样式") {
            VStack {
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(GaugeProgressStyle())
                    .frame(width: 200, height: 200)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if progress < 1.0 {
                            withAnimation {
                                progress += 0.2
                            }
                        }
                    }
            }
        }
    }
}

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.blue
    var strokeWidth = 25.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }
}


//-----------------------------
struct UsingButtonStyleCustomizingButton : View {
    var body: some View {
        TestWrap("使用ButtonStyle自定义按钮样式，为了复用，有系统预设的") {
            VStack {
                Button("Press Me") {
                    print("Button pressed!")
                }
//                .padding()
//                .background(Color(red: 0, green: 0, blue: 0.5))
//                .clipShape(Capsule())
                
                
//                .buttonStyle(BlueButton())
                
                .buttonStyle(GrowingButton())
            }
        }
    }
}
struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct GrowingButton: ButtonStyle {
    //按下去会变大的按钮风格
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

//-----------------------------
struct AdjustViewsTintingMore : View {
    var body: some View {
        TestWrap("调整视图的亮度、色调、色调、饱和度等") {
            VStack {
                //这将创建一个图像视图，并将整个对象染成红色
                Image("header")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .colorMultiply(.red)
                //饱和度调整为任意数量，其中0.0表示完全灰色，1.0表示其原始颜色
                Image("header")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .saturation(0.3)
                //动态调整视图的对比度。值为0.0时不会产生对比度（平坦的灰色图像），值为1.0时会生成原始图像，值大于1.0时会增加对比度。
                Image("header")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .contrast(0.5)//将图像对比度降低到50%
            }
        }
    }
}
//-----------------------------
struct BlendViews: View {
    var body: some View {
        TestWrap("图层混合模式") {
            VStack {
                ZStack {
                    Circle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .offset(x: -50)
                        .blendMode(.multiply)

                    Circle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                        .offset(x: 50)
                        .blendMode(.screen)
                }
                .frame(width: 400)
            }
        }
    }
}
//-----------------------------
struct BlurAnView: View {
    @State private var blurAmount = 0.0
    var body: some View {
        TestWrap("模糊视图") {
            VStack {
                Image("header")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .blur(radius: 10)
                
                Text("Welcome to my SwiftUI app")
                    .blur(radius: 2)
                //模糊是高效的
                Text("Drag the slider to blur me")
                    .blur(radius: blurAmount)

                Slider(value: $blurAmount, in: 0...20)
            }
        }
    }
}
//-----------------------------
struct MaskOneView: View {
    @State private var opacity = 0.5
    var body: some View {
        TestWrap("使用蒙版") {
            VStack {
                
                Image("header")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .mask(
                        Text("SWIFT!")
                            .font(.system(size: 72))
                            .opacity(opacity)
                    )
                
                Slider(value: $opacity, in: 0...1)
            }
            .accentColor(.orange)
        }
    }
}
//-----------------------------
struct AdjustAccentColor: View {
    //当您设置一个视图的强调颜色时，它会影响其中的所有视图，因此如果您设置顶级控件的访问颜色，则所有视图都会着色。
    var body: some View {
        TestWrap("调整顶层访问颜色") {
            VStack {
                Button("Press Here") {
                    print("Button pressed!")
                }
            }
            .accentColor(.orange)
        }
    }
}
//-----------------------------
struct AdjustOpacity: View {
    @State private var opacity = 0.5
    var body: some View {
        TestWrap("调整透明度") {
            VStack {
                Text("Now you see me")
                    .padding()
                    .background(.red)
                    .opacity(0.3)
                
                Text("Now you see me")
                    .padding()
                    .background(.red)
                    .opacity(opacity)

                Slider(value: $opacity, in: 0...1)
                    .padding()
            }
        }
    }
}
//-----------------------------
struct RoundCorners: View {
    
    var body: some View {
        TestWrap("给视图加圆角") {
            VStack {
                Text("Round Me")
                    .padding()
                    .background(.red)
                    .cornerRadius(15)
                
                Text("Round Me")
                    .padding()
                    .background(.red)
                    .clipShape(Capsule())
            }
        }
    }
}
//-----------------------------
struct ScaleAView: View {
    
    var body: some View {
        TestWrap("缩放视图") {
            //放大视图不会导致它以新的大小重新绘制，只会向上或向下拉伸。这意味着小文本将看起来模糊，而小图像可能看起来像像素化或模糊。
            VStack {
                Text("Up we go")
//                    .scaleEffect(2)
//                    .scaleEffect(x: 1, y: 5)//分别控制缩放
                    .scaleEffect(2, anchor: .bottomTrailing)//指定锚点缩放
//                    .frame(width: 300, height: 300)
            }
        }
    }
}
//-----------------------------
struct RotateAView3D: View {
    
    var body: some View {
        TestWrap("3D旋转视图") {
            VStack {
                Text("EPISODE LLVM")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
            }
        }
    }
}

//-----------------------------
struct RotateAView: View {
    @State private var rotation = 0.0
    var body: some View {
        TestWrap("旋转视图") {
            VStack {
                Text("Up we go")
                    .rotationEffect(.degrees(-90))
                
                Text("Up we go")
                    .rotationEffect(.radians(.pi))
                
                Slider(value: $rotation, in: 0...360)
                //默认围绕中心旋转
                Text("Up we go")
                    .rotationEffect(.degrees(rotation))
                //围绕锚点旋转
                Text("Up we go")
                    .rotationEffect(.degrees(rotation), anchor: .topLeading)
            }
        }
    }
}

//-----------------------------
struct ClipAView: View {
    
    var body: some View {
        TestWrap("裁剪视图") {
            VStack {
                Button {
                    print("Button was pressed!")
                } label: {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(.green)
                        .clipShape(Circle())
                }
                
                Button {
                    print("Pressed!")
                } label: {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .background(.green)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

//-----------------------------
struct DrawShadow: View {
    @State private var phase = 0.0
    var body: some View {
        TestWrap("绘制阴影") {
            //如果您发现阴影效果不够强，请添加另一个shadow（）修饰符–您可以将它们堆叠起来以创建更复杂的阴影效果。
            VStack {
                Text("Hacking with Swift")
                    .foregroundColor(.black)
                    .padding()
//                    .shadow(radius: 5)
//                    .shadow(color: .red, radius: 5)
//                    .shadow(color: .red, radius: 5, x: 20, y: 20)
//                    .border(.red, width: 4)
                //只要调整modifier，就可以将阴影应用到边框
                    .border(.red, width: 4)
                    .shadow(color: .red, radius: 5, x: 20, y: 20)
                    .background(.white)
            }
        }
    }
}

//-----------------------------
struct MarchingAntsBorder: View {
    @State private var phase = 0.0
    var body: some View {
        TestWrap("虚线边框") {
            VStack {
                Rectangle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10]))
                    .frame(height: 100)
                
                Rectangle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [10], dashPhase: phase))
                    .frame(width: 200, height: 200)
                    .onAppear {
                        withAnimation(.linear.repeatForever(autoreverses: false)) {
                            phase -= 20
                        }
                    }
            }
        }
    }
}
//-----------------------------
struct DrawBorderInside: View {
    
    var body: some View {
        TestWrap("View内部画边框") {
            VStack {
//                strokeBorder（）修饰符按边框宽度的一半插入视图，然后应用笔划，这意味着整个边框都绘制在视图内。
//                stroke（）修饰符以视图的边为中心绘制边界，这意味着一半的边界在视图内部，一半在视图外部。
                Circle()
                    .strokeBorder(.blue, lineWidth: 50)
                    .frame(width: 200, height: 200)
                    .padding()
                
                Circle()
                    .stroke(.blue, lineWidth: 50)
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
        }
    }
}
//-----------------------------
struct DrawBorderAround: View {
    
    var body: some View {
        TestWrap("View外部画边框") {
            VStack {
                Text("Hacking with Swift")
                    .border(.green)
                
                Text("Hacking with Swift")
                    .padding()
                    .border(.green)
                
                Text("Hacking with Swift")
                    .padding()
                    .border(.red, width: 4)
                
                Text("Hacking with Swift")
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.blue, lineWidth: 4)
//                            .strokeBorder(.red)
                    )
            }
            
        }
    }
}
//-----------------------------
struct MoreModifier: View {
    @State private var showingSheet = false
    var body: some View {
        TestWrap("modifier叠加使用，产生不同的效果") {
            Text("Forecast: Sun")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(.red)
                .padding()
                .background(.orange)
                .padding()
                .background(.yellow)
        }
    }
}
//-----------------------------
struct UsingOffset: View {
    @State private var showingSheet = false
    var body: some View {
        TestWrap("使用Offset调整 位置") {
            VStack {
//                Text("Home")
//                Text("Options")
//                    .offset(y: 15)
//                Text("Help")
                
                //padding与offset结合使用，形成想要的布局
                //刚好间距形成15
                Text("Home")
                Text("Options")
                    .offset(y: 15)
                    .padding(.bottom, 15)
                Text("Help")
                //在ZStack中使用
                ZStack(alignment: .bottomTrailing) {
                    Image("header")
                        .resizable()
                        .frame(width: 350, height: 200, alignment: .center)
                    Text("Photo credit: Paul Hudson.")
                        .padding(4)
                        .background(.black)
                        .foregroundColor(.white)
                        .offset(x: -5, y: -5)
                }
            }
            .background(.yellow)
        }
    }
}


//-----------------------------

struct TransformingViewsDemo_Previews: PreviewProvider {
    static var previews: some View {
        TransformingViewsDemo()
    }
}
