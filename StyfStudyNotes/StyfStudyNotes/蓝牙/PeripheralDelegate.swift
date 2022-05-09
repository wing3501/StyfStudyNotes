//
//  PeripheralDelegate.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/7.
//

import Foundation
import CoreBluetooth

class PeripheralDelegate: NSObject,CBPeripheralDelegate {
    public static let shared = PeripheralDelegate()
    
    weak var peripheral: CBPeripheral?
    var didDiscoverServices: (([CBService]) -> Void)?
    var didDiscoverCharacteristics: (([CBCharacteristic]) -> Void)?
    
    
    
//    var services: [CBService] = []
    var characteristicsDic: [CBService: [CBCharacteristic]] = [:]
    var characteristicDescDic: [CBCharacteristic: String] = [:]
    var characteristicReadValueDic: [CBCharacteristic: String] = [:]
    
    //This method returns the result of a @link discoverServices: @/link call. If the service(s) were read successfully
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        self.peripheral = peripheral
        let peripheralName = peripheral.name ?? "unknow"
        guard error == nil else {
            print("发现服务失败:\(peripheralName) \(error!.localizedDescription)")
            return
        }
        
        if let services = peripheral.services {
            print("\(peripheralName) 服务如下：\(services.count)")
            for service in services {
                print("service: \(service.uuid.uuidString)")
                //如果我们知道要查询的特性的CBUUID，可以在参数一中传入CBUUID数组。
//                peripheral.discoverCharacteristics(nil, for: service) //查询特性
            }
//            self.services = services
            if let callback = didDiscoverServices {
                callback(services)
            }
        }else {
            print("\(peripheralName) 未发现可用服务")
        }
    }
    
    // This method returns the result of a @link discoverCharacteristics:forService
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            print("发现特性失败,服务UUID：\(service.uuid) \(error!.localizedDescription)")
            return
        }
        
        guard let characteristics = service.characteristics else {
            print("发现特性失败,服务UUID：\(service.uuid)")
            return
        }
        
        characteristicsDic[service] = characteristics
//        print("\(service.uuid.uuidString)的特性如下：")
        
        for character in characteristics {
            var desc = ""
            let properties = character.properties
            if properties.contains(.broadcast) {
//                print("广播特性")
                desc += "broadcast "
            }
            if properties.contains(.read) {
//                print("可读特性")
                desc += "read "
                //如果具备读特性，即可以读取特性的value
                peripheral.readValue(for: character)
            }
            if properties.contains(.writeWithoutResponse) {
                desc += "writeWithoutResponse "
//                print("写入不响应特性")
                //这里保存这个可以写的特性，便于后面往这个特性中写数据
//                  _chatacter = character;
//                想要向蓝牙外设写入数据，则调用如下方法：
//                [peripheral writeValue:infoData forCharacteristic:_chatacter type:CBCharacteristicWriteWithoutResponse];
            }
            if properties.contains(.write) {
                desc += "write "
//                print("可写特性")
                //如果具备写入值的特性，这个应该会有一些响应
            }
            if properties.contains(.notify) {
                desc += "notify "
//                print("通知特性")
                //通知特性，无响应
//                特征值具有Notify权限才可以进行订阅，订阅之后该特征值的value发生变化才会回调didUpdateValueForCharacteristic
                peripheral.setNotifyValue(true, for: character)
            }
            characteristicDescDic[character] = desc
        }
        
        if let callbalck = didDiscoverCharacteristics {
            callbalck(characteristics)
        }
    }
    
    /**
     *  @method peripheral:didUpdateNotificationStateForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *    对应通知的回调
     *  @discussion                This method returns the result of a @link setNotifyValue:forCharacteristic: @/link call.
     */
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("❌ didUpdateNotificationState:\(error.localizedDescription)")
            return
        }
        
//        CBCharacteristicProperties properties = characteristic.properties;
//        if (properties & CBCharacteristicPropertyRead) {
//            //如果具备读特性，即可以读取特性的value
//            [peripheral readValueForCharacteristic:characteristic];
//        }
        print("didUpdateNotificationState success")
    }
    
    /**
     *  @method peripheral:didUpdateValueForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *   读特性回调
     *  @discussion                This method is invoked after a @link readValueForCharacteristic: @/link call, or upon receipt of a notification/indication.
     */
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("❌ didUpdateValueFor:\(error.localizedDescription)")
            return
        }
        
        if let data = characteristic.value {
            print("蓝牙外设回复数据--UUID:\(characteristic.uuid.uuidString)---\(data)")
        }
        
//        if let data = characteristic.value,let value = String(data: data, encoding: .utf8) {
//            characteristicReadValueDic[characteristic] = value
//            print("可读值：\(value)")
//        }
    }
    
    /**
     *  @method peripheral:didWriteValueForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a {@link writeValue:forCharacteristic:type:} call, when the <code>CBCharacteristicWriteWithResponse</code> type is used.
     */
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
}
