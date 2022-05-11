//
//  ImageShapeMedia.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/11.
//

import SwiftUI
import AVKit

struct ImageShapeMedia: View {
    var body: some View {
        ScrollView {
            VStack {
                SymbolRenderingModeTest()
                LoadARemoteImage()
                PlayMovies()
                ContainerRelativeShapeTest()
                VStack {
                    TrimShape()
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
    }
}

struct SymbolRenderingModeTest: View {
    var body: some View {
        TestWrap("SF Symbols的颜色控制") {
            VStack {
                Image(systemName: "theatermasks")
                    .symbolRenderingMode(.hierarchical)//分层
                    .foregroundColor(.blue)
                    .font(.system(size: 144))
                
                //使用palette完全控制
                Image(systemName: "shareplay")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .black)
                    .font(.system(size: 144))
                //颜色的个数取决于符号本身的图层的个数
                Image(systemName: "person.3.sequence.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .green, .red)
                    .font(.system(size: 144))

            }
        }
    }
}

struct LoadARemoteImage: View {
    var body: some View {
        TestWrap("AsyncImage的使用") {
//            VStack {
//                AsyncImage(url: URL(string: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png"))
//            }
//            .frame(height: 100, alignment: .center)
            
            AsyncImage(url: URL(string: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png")) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            //系统默认当图片是1倍图，如果有需要的话，可以指定为2倍图
//            AsyncImage(url: URL(string: "https://www.hackingwithswift.com/img/paul@2x.png"), scale: 2)
        }
    }
}

struct PlayMovies: View {
    var body: some View {
        TestWrap("VideoPlayer播放视频") {
            //本地视频
//            VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "IMG_1599", withExtension: "MP4")!))
//                .frame(height: 400)
            //网络视频
//            VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!))
//                .frame(height: 400)
            //在视频上绘制控制按钮、水印   会在视频控制组件的下方绘制，但可以响应
            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "IMG_1599", withExtension: "MP4")!)) {
                Text("水印")
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.7))
                Spacer()
            }
            .frame(height: 400)
        }
    }
}

struct ContainerRelativeShapeTest: View {
    var body: some View {
        TestWrap("ContainerRelativeShape的使用") {
            ZStack {
                ContainerRelativeShape()
                    .inset(by: 10)
                    .fill(Color.blue)

                Text("Hello, World!")
                    .font(.title)
            }
            .frame(width: 300, height: 200)
            .background(Color.red)
            .clipShape(Capsule())
        }
    }
}

struct TrimShape: View {
    var body: some View {
        TestWrap("使用trim绘制填充部分Shape") {
            Circle()
                .trim(from: 0, to: 0.75)//提供一个起点和终点的值  0度在右边，从右边开始，所以要从上开始绘制
                                        //就要使用rotationEffect()
                .frame(width: 50, height: 50)
            TrimShape1()
        }
    }
}

struct TrimShape1: View {
    @State private var completionAmount: CGFloat = 0.0
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        var body: some View {
            Rectangle()
                .trim(from: 0, to: completionAmount)
                .stroke(Color.red, lineWidth: 20)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))//正常从左上角开始
                .onReceive(timer) { _ in
                    withAnimation {
                        if completionAmount == 1 {
                            completionAmount = 0
                        } else {
                            completionAmount += 0.2
                        }
                    }
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
