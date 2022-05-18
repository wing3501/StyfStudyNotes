//
//  CharacteristicsView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/7.
//

import SwiftUI
import CoreBluetooth

extension CBCharacteristic: Identifiable {
    
}

struct CharacteristicsView: View {
    var service: CBService?
    @State var characteristics: [CBCharacteristic] = []
    var body: some View {
        List(characteristics) { characteristic in
            VStack {
                if let desc = PeripheralDelegate.shared.characteristicDescDic[characteristic] {
                    Text("支持特性：\(desc)")
                }
                if let readString = PeripheralDelegate.shared.characteristicReadValueDic[characteristic] {
                    Text("可读值:\(readString)")
                }
            }
        }
        .onAppear {
            if let service = service {
                characteristics = PeripheralDelegate.shared.characteristicsDic[service]!
            }
        }
    }
}

struct CharacteristicsView_Previews: PreviewProvider {
    static var previews: some View {
//        CharacteristicsView()
        EmptyView()
    }
}
