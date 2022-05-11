//
//  ImageShapeMedia.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/11.
//

import SwiftUI

struct ImageShapeMedia: View {
    var body: some View {
        ScrollView {
            FillStrokeShapes()
            ShapesTest()
            BackgroundTest()
            GradientTest()
            SFSymbolsImage()
            TileAnImage()
            AdjustImageSpace()
            ImageBaseUse()
        }
    }
}

struct FillStrokeShapes: View {
    var body: some View {
        TestWrap("填充绘制形状") {
            VStack {
                Circle()
                    .strokeBorder(Color.black, lineWidth: 10)//添加一个边框
                    .background(Circle().fill(Color.blue))//保证内圆的颜色
//                    .background(.blue)//这里如果直接用背景就是整个矩形的背景色
                    .frame(width: 50, height: 50)
                
                ZStack {//另一种方案
                    Circle()
                        .fill(Color.red)

                    Circle()
                        .strokeBorder(Color.black, lineWidth: 10)
                }
                .frame(width: 50, height: 50)
            }
        }
    }
}
// 如果有多个形状要填充，可以考虑写两个个扩展
extension Shape {//一个处理常规形状
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: CGFloat = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
extension InsettableShape {//一个处理可插入形状
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: CGFloat = 1) -> some View {
        self
            .strokeBorder(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}

struct ShapesTest: View {
    var body: some View {
        TestWrap("形状的使用") {
            VStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green)
                    .frame(width: 75, height: 50)
                Capsule()
                    .fill(Color.green)
                    .frame(width: 75, height: 50)
            }
        }
    }
}

struct BackgroundTest: View {
    var body: some View {
        TestWrap("各种背景") {
            VStack {
                Text("图片作为背景")
                    .font(.system(size: 48))
                    .padding(50)
                    .background(
                        Image("Pokemon-25")
                            .resizable()
                    )
                Text("形状作为背景")
                    .font(.largeTitle)
                    .padding()
                    .background(Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50))
                Text("裁掉背景超出部分")
                    .font(.largeTitle)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 100, height: 100)
                    )
                    .clipped()
            }
        }
    }
}

struct GradientTest: View {
    var body: some View {
        TestWrap("渐变色的使用") {
            VStack {
                Text("渐变色的使用")
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                    )
                Circle()
                    .fill(
                        RadialGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startRadius: 25, endRadius: 50)
                    )
                    .frame(width: 100, height: 100)
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                    )
                    .frame(width: 100, height: 100)
                Circle()
                    .strokeBorder(
                        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                        lineWidth: 5
                    )
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct SFSymbolsImage: View {
    var body: some View {
        TestWrap("SF Symbols图片") {
            VStack {
                Image(systemName: "cloud.heavyrain.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                
                Image(systemName: "cloud.sun.rain.fill")
                    .renderingMode(.original)//激活Icon原有的多种填充色
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black)
                    .clipShape(Circle())
                
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .renderingMode(.original)
                    .foregroundColor(.blue)//修改多色icon的部分颜色
                    .font(.largeTitle)
            }
        }
    }
}

struct TileAnImage: View {
    var body: some View {
        TestWrap("如何平铺图像") {
            VStack {
                Image("baike")
//                    .resizable(resizingMode: .tile) //平铺满
                    .resizable(capInsets: EdgeInsets(top: 2, leading: 2, bottom: -5, trailing: -2), resizingMode: .tile)//平铺一部分
            }
            .frame(width: 100, height: 100, alignment: .center)
        }
    }
}

struct AdjustImageSpace: View {
    var body: some View {
        TestWrap("调整图像与空间的匹配方式") {
            VStack {
                Image("header")
                    .resizable()//铺满可用空间
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
        }
    }
}

struct ImageBaseUse: View {
    var body: some View {
        TestWrap("Image的基本使用") {
            VStack {
                Image("baike")
                Image(uiImage: UIImage(named: "baike")!)
                Image(systemName: "cloud.heavyrain.fill")
                    .font(.largeTitle)
            }
        }
    }
}

struct ImageShapeMedia_Previews: PreviewProvider {
    static var previews: some View {
        ImageShapeMedia()
    }
}
