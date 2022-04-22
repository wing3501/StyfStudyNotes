//
//  PokemonInfoPanelAbilityList.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation
import SwiftUI

extension PokemonInfoPanel {
    struct AbilityList: View {
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                
                if abilityModels != nil {
                    ForEach(abilityModels!) { ability in
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
