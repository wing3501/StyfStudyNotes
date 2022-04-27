//
//  PokemonInfoPanel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    @State var darkBlur = false
    
    let model: PokemonViewModel
    
    var abilities: [AbilityViewModel] = []
    
    var pokemonDescription: some View {
        Text("最后一行的 fixedSize 修饰符用来告诉 SwiftUI 保持 View 的理想尺寸，让它不被上层 View “截断”")
            .font(.callout)
            .foregroundColor(.gray)
            .fixedSize(horizontal: false, vertical: true)//可以在竖直方向上显示全部文本，同时在水平方向上保持按照上层 View 的限制来换行。
    }
    
    var topIndicator: some View {
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                darkBlur.toggle()
            } label: {
                Text("切换模糊效果")
            }

            topIndicator
            Group {
                Header(model: model)
                pokemonDescription
            }
            .animation(nil, value: false)//显示指明这部分不要动画
            Divider()
            AbilityList(model: model, abilityModels: abilities)
        }
        .padding(EdgeInsets(top: 12, leading: 30, bottom: 30, trailing: 30))
//        .background(.white)
        .blurBackground(style: darkBlur ? .systemMaterialDark : .systemMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
//        PokemonInfoPanel(model: PokemonViewModel(), abilities: [AbilityViewModel()])
        PokemonInfoPanel(model: PokemonViewModel(Pokemon(id: 1, species: PokemonSpecies(name: "", url: "")), PokemonSpecies(name: "", url: "")))
    }
}
