//
//  PokemonList.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import SwiftUI

struct PokemonList: View {
//    添加 @State 将会使该属性被修改时触发 ScrollView 的计算 和重绘，以保证尺寸正确。
    @State var expandingIndex: Int?
    var body: some View {
        //List 接受一个数组，数组中的元素需要遵守 Identifiable 协议
//        List(PokemonViewModel.all) { pokemon in
//            PokemonInfoRow(model: pokemon, expanded: false)
//        }
        //和 List 不同，ScrollView 并没有一个接受数组数据的初始化方法。我们需要使用 DSL 来描述它的内容。
        //ScrollView 暂时没有内建的 cell 重用机制
        ScrollView {
            ForEach(PokemonViewModel.all) { pokemon in
                PokemonInfoRow(model: pokemon, expanded: expandingIndex == pokemon.id)
                    .onTapGesture {
                        if expandingIndex == pokemon.id {
                            expandingIndex = nil
                        }else {
                            expandingIndex = pokemon.id
                        }
                    }
            }
        }
//        overlay 在当前 View (ScrollView) 上方添加一层另外的 View。它的行为和 ZStack 比较相似，只不过 overlay 会尊重它下方的原有 View 的布局，而不像 ZStack 中的 View 那样相互没有约束。
        .overlay(
            VStack {
                Spacer()
                PokemonInfoPanel(model: PokemonViewModel(), abilities: [AbilityViewModel()])
            }.edgesIgnoringSafeArea(.bottom)//忽略 safe area
        )
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}