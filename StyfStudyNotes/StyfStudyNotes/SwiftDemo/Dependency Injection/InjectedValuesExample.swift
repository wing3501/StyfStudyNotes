//
//  InjectedValuesExample.swift
//  TestSwiftUI
//
//  Created by 申屠云飞 on 2023/8/10.
//

import UIKit

protocol NetworkProviding {
    func requestData()
}

struct NetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `NetworkProvider`")
    }
}

struct MockedNetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `MockedNetworkProvider`")
    }
}

struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = NetworkProvider()
}

extension InjectedValues {
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}


class InjectedValuesExample: UIViewController {
    @Injected(\.networkProvider)
    var networkProvider: NetworkProviding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InjectedValues[\.networkProvider] = MockedNetworkProvider()
        print(networkProvider) // prints: MockedNetworkProvider()

//        networkProvider = NetworkProvider()
//        print(networkProvider) // prints 'NetworkProvider' as we overwritten the property wrapper wrapped value

        performDataRequest() // prints: Data requested using the 'NetworkProvider'
    }
    

    func performDataRequest() {
        networkProvider.requestData()
    }
}
