//
//  PokemonInfoPanelHeader.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation
import SwiftUI

extension PokemonInfoPanel {
    struct Header: View {
        let model: PokemonViewModel
        
        var body: some View {
            HStack(spacing: 18) {
                pokemonIcon
                nameSpecies
                verticalDivider
                 VStack(spacing: 12) {
                 bodyStatus
                 typeInfo
                }
            }
        }
        
        var pokemonIcon: some View {
            Image("Pokemon-25")
                .resizable()
                .frame(width: 68, height: 68)
        }
        
        var nameSpecies:some View {
            VStack {
                Text("中文名称")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                Text("英文名称")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                Text("这是种类")
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.top,5)
            }
        }
        
        var verticalDivider: some View {
            Rectangle()
                .frame(width: 1, height: 44)
                .foregroundColor(.red)
                .opacity(0.1)
        }
        
        var bodyStatus: some View {
            VStack {
                HStack {
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("0.7m")
                        .font(.system(size: 11))
                        .foregroundColor(.green)
                }
                HStack {
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("6.9kg")
                        .font(.system(size: 11))
                        .foregroundColor(.green)
                }
            }
        }
        
        var typeInfo: some View {
            HStack(alignment: .center, spacing: 8) {
                Text("草")
                    .font(.system(size: 8))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 14, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 7).foregroundColor(.green))
                Text("毒")
                    .font(.system(size: 8))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 14, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 7).foregroundColor(.purple))
            }
        }
    }
}
