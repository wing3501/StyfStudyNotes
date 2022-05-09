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
    
    var servicesList: some View {
        List($services) { service in
            PeripheralServiceRow(service: service)
        }
    }
}

struct PeripheralServiceRow: View {
    @Binding var service: CBService
    @State var activeNavigation = false
    
    var body: some View {
        VStack {
//            NavigationLink(isActive: $activeNavigation) {
//                CharacteristicsView(service: service)
//                    .navigationTitle("\(service.uuid.uuidString)")
//            } label: {
//
//            }
            Text("\(service.uuid.uuidString)")
        }
        .frame(height: 50)
        .onTapGesture {
                print("点击了----\(service.uuid.uuidString)")
            //如果我们知道要查询的特性的CBUUID，可以在参数一中传入CBUUID数组。
            if let peripheral = service.peripheral {
//                    print("查询服务的特性---\(service.uuid.uuidString)")
                PeripheralDelegate.shared.didDiscoverCharacteristics = { characteristics in
                    activeNavigation = true
                }
                peripheral.discoverCharacteristics(nil, for: service) //查询特性
            }
        }
    }
}

struct PeripheralServicesView_Previews: PreviewProvider {
    static var previews: some View {
//        PeripheralServicesView()
        EmptyView()
    }
}
