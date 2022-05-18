//
//  PeripheralServicesView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/7.
//

import SwiftUI
import CoreBluetooth

extension CBService: Identifiable {
    
}

struct PeripheralServicesView: View {
    @State var services: [CBService]
    var body: some View {
        NavigationView {
            servicesList.navigationTitle("\(PeripheralDelegate.shared.peripheral != nil ? PeripheralDelegate.shared.peripheral!.name! : "unknow")")
        }
    }
    @State var chooseServoce: CBService?
    @State var activeNavigation = false
    
    var servicesList: some View {
        VStack {
            NavigationLink(isActive: $activeNavigation) {
                CharacteristicsView(service: chooseServoce)
                    .navigationTitle("\((chooseServoce != nil ? chooseServoce!.uuid.uuidString : "unknow"))")
            } label: {
                EmptyView()
            }
            List($services) { service in
                PeripheralServiceRow(service: service, chooseServoce: $chooseServoce,activeNavigation: $activeNavigation)
            }
        }
    }
}

struct PeripheralServiceRow: View {
    @Binding var service: CBService
    @Binding var chooseServoce: CBService?
    @Binding var activeNavigation: Bool
    
    var body: some View {
        HStack {
            Text("\(service.uuid.uuidString)")
            Spacer()
        }
        .frame(minHeight: 50)
        .contentShape(Rectangle())
        .onTapGesture {
                print("点击了----\(service.uuid.uuidString)")
            //如果我们知道要查询的特性的CBUUID，可以在参数一中传入CBUUID数组。
            if let peripheral = service.peripheral {
//                    print("查询服务的特性---\(service.uuid.uuidString)")
                PeripheralDelegate.shared.didDiscoverCharacteristics = { characteristics in
                    chooseServoce = service
                    activeNavigation = true
                }
                peripheral.discoverCharacteristics(nil, for: service) //查询特性
            }
        }
    }
}

struct PeripheralServicesView_Previews: PreviewProvider {
    static var previews: some View {
        PeripheralServicesView(services: [])
//        EmptyView()
    }
}
