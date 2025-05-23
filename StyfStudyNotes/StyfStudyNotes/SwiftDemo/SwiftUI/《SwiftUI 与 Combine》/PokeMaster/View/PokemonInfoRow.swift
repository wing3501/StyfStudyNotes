//
//  PokemonInfoRow.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/21.
//

import SwiftUI
import Kingfisher

struct PokemonInfoRow: View {
    let model: PokemonViewModel
    let expanded: Bool
//    @State var expanded: Bool
    
    @EnvironmentObject var store: Store
    
    var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }
    var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    
//    isSFViewActive 控制的不仅仅是自身 View 中临时状态，而是影响了整个 app UI 结 构的状态。简单地使用这样的 @State，破坏了 model 和 view 的对应关系。我们会 想办法将这个状态放到 AppState 里，用 AppAction 来修改状态并驱动 UI。
//    @State var isSFViewActive = false
    
    var body: some View {
        VStack {
            HStack {//图片，名字
//                Image("Pokemon-25")
//                KFImage(URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(model.id).png")!)
                KFImage(URL(string: "https://img2.baidu.com/it/u=2229712510,2079475217&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500")!)
                    .resizable() //如果我们想要图片可以按照所在的 frame 缩放，需要添加 resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("中文名")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text("英文名")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
            }
            .padding(.top,12)
            Spacer()
            HStack(spacing: expanded ? 20: -30) {//按钮部分
                Spacer()
                Button {
                    store.dispatch(.collect)
                } label: {
                    Image(systemName: "star") //加载系统内置的 SF Symbol
                        .modifier(ToolButtonModifier())
                }
                Button {
                    let target = !store.appState.pokemonList.selectionState.panelPresented
                    store.dispatch(.togglePanelPresenting(presenting: target))
                } label: {
                    Image(systemName: "chart.bar")
                        .modifier(ToolButtonModifier())
                }
                Button {
                    //使用sheet弹出SafariView
                    store.dispatch(.sheetOpenSafariView)
                } label: {
                    Image(systemName: "info.circle")
                        .modifier(ToolButtonModifier())
                }
                
//                想要以推入 的方式显示新 View，需要使用 NavigationLink。
//                注意，NavigationLink 只在当前 View 处于 NavigationView 中才有效。在我 们的例子中，NavigationView 被定义在 PokemonRootView 里。
//                NavigationLink {
//                    SafariView(url: URL(string: "http://news.baidu.com/")!)
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationTitle(Text("我是一个标题"))
//                } label: {
//                    Image(systemName: "info.circle")
//                        .modifier(ToolButtonModifier())
//                }
                
                
//                除了 像上面那样最简单的 init(destination:label:) 以外，NavigationLink 还有另外的接受 一个 Binding<Bool> 的初始化方法。
//                NavigationLink(isActive: expanded ? pokemonListBinding.isSFViewActive : .constant(false)) {
//                    SafariView(url: URL(string: "http://news.baidu.com/")!) {
//                        store.dispatch(.closeSafariView)
//                    }
//                    .navigationBarTitleDisplayMode(.inline)
//                    .navigationTitle(Text("我是一个标题"))
//                } label: {
//                    Image(systemName: "info.circle")
//                        .modifier(ToolButtonModifier())
//                }
            }
            .padding(.bottom,12)
            .opacity(expanded ? 1.0 : 0.0)//设定透明度来隐藏按钮
            .frame( maxHeight: expanded ? .infinity : 0)
        }
        .frame(height: expanded ? 120 : 80)
        .padding(.leading, 23)
        .padding(.trailing, 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                .stroke(.yellow, style: StrokeStyle(lineWidth: 4))//对于同样的 RoundedRectangle，使 用 stroke 来获取它的轮廓，并将轮廓和渐变背景用 ZStack 堆叠起来
                RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.white,.yellow]), startPoint: .leading, endPoint: .trailing))//渐变色的使用
            }
        )//实际上这个方法可以接受任意遵守 View 协议的值。比如我们所需要的一个圆角矩形的形状
        .padding(.horizontal)
        //隐式动画，通过 View 上的 animtion 修饰，就可以在 View 中支持动画的属性发生变化时自动为整个 View 添加上动画支持了
        .animation(.spring(response: 0.55, dampingFraction: 0.425, blendDuration: 0), value: expanded)
//        .animation(.spring(response: 0.55, dampingFraction: 0.425, blendDuration: 0))
//        .onTapGesture {
//            SwiftUI 中的动画有两种类型:显式动画和隐式动画。显式动画通过 withAnimation 触发
//            withAnimation {
//                expanded.toggle()
//            }
//            其他效果
//            let animation = Animation
//                .linear(duration: 0.5)
//                .delay(0.2)
//                .repeatForever(autoreverses: true)
//            withAnimation(animation) {
//                expanded.toggle()
//            }
//        }
    }
}

//ViewModifier 可以跨越页面并作用在任意 View 上，因此在大型项目中，合理使 用 ViewModifier 来减少重复和维护难度会是很常见的做法
struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
              .font(.system(size: 25))
              .foregroundColor(.white)
              .frame(width: 30, height: 30)//.font(.system(size: 25)) 虽然可以控制图片的显示尺寸，但是它并不会改变 Image 本身的 frame。
    }
}


struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
//            PokemonInfoRow(model: PokemonViewModel(), expanded: false)
//            PokemonInfoRow(model: PokemonViewModel(), expanded: true)
//            PokemonInfoRow(model: PokemonViewModel(), expanded: false)
        }
    }
}
