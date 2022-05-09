//
//  BluetoothDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/6.
//

import UIKit
import CoreBluetooth
import SwiftUI

class PeripheralModel: Equatable {
    let peripheral: CBPeripheral
    let advertisementData: [String : Any]
    let RSSI: NSNumber
    init(_ peripheral:CBPeripheral,_ advertisementData: [String : Any],_ RSSI: NSNumber) {
        self.peripheral = peripheral
        self.advertisementData = advertisementData
        self.RSSI = RSSI
    }
    
    static func == (lhs: PeripheralModel, rhs: PeripheralModel) -> Bool {
        lhs.peripheral.identifier == rhs.peripheral.identifier
    }
}

@objc(BluetoothDemo)
@objcMembers class BluetoothDemo: UIViewController {
    
    let queue = DispatchQueue(label: "myQueue")
    
    var centralManager: CBCentralManager?
    
    // 准备连接的外设
    var peripheral: CBPeripheral?
    
    lazy var tableView: UITableView = {
        let v = UITableView(frame: UIScreen.main.bounds, style: .plain)
        v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        v.dataSource = self;
        v.delegate = self;
        return v
    }()
    
    var dataDic: [UUID: Int] = [:]
    var dataArray: [PeripheralModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        let options: [String : Any] = [
            CBCentralManagerOptionShowPowerAlertKey:true, //当设为YES时，表示CentralManager初始化时，如果蓝牙没有打开，将弹出Alert提示框
            CBCentralManagerOptionRestoreIdentifierKey:"styf_bte" //对应的是一个唯一标识的字符串，用于蓝牙进程被杀掉恢复连接时用的。
        ]
    
//        centralManager = CBCentralManager(delegate: self, queue: nil, options: options) //only allowed for applications that have specified the "bluetooth-central" background mode'
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension BluetoothDemo: CBCentralManagerDelegate {
    
    /// 权限状态变更
    /// - Parameter central: <#central description#>
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //确保本中心设备支持蓝牙低能耗（BLE）并开启时才能继续操作
        switch central.state{
        case .unknown:
            print("未知")
        case .resetting:
            print("蓝牙重置中")
        case .unsupported:
            print("本机不支持BLE")
        case .unauthorized:
            print("未授权")
        case .poweredOff:
            print("蓝牙可用，未开启")
        case .poweredOn:
            print("蓝牙已开启")
            // 扫描正在广播的外设--每当发现外设时都会调用didDiscover peripheral方法
            // 第一个参数是服务的CBUUID数组，我们可以搜索具有某一类服务的蓝牙设备
            central.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false,CBCentralManagerOptionShowPowerAlertKey:true])
        @unknown default:
            print("来自未来的错误")
        }
    }
    
    /// 扫描到了一个外设
    /// - Parameters:
    ///   - central: 管理
    ///   - peripheral: 扫描到的蓝牙外设
    ///   - advertisementData: 蓝牙外设中 的额外数据  advertisementData是广播的值，一般携带设备名、serviceUUIDs等信息
    ///   - RSSI: 信号强度的参数    RSSI绝对值越大，表示信号越差，设备离的越远。
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let name = peripheral.name else { return }
        print("扫描到了---->name:\(name) identifier:\(peripheral.identifier) RSSI:\(RSSI)")
        
        let newModel = PeripheralModel(peripheral, advertisementData, RSSI)
        if let peripheralIndex = dataDic[peripheral.identifier] {
            dataArray[peripheralIndex] = newModel
        }else {
            dataArray.append(newModel)
            dataDic[peripheral.identifier] = dataArray.count - 1
        }
        
        tableView.reloadData()
    }
    // 连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // 既然已经连接到某个蓝牙了，那就不需要在继续扫描外设了
        central.stopScan()
        
        //即将要使用peripheral的delegate方法，所以先委托self
        //寻找服务--立即（由已连接上的peripheral来）调用didDiscoverServices方法
        // 设置外设的代理是为了后面查询外设的服务和外设的特性，以及特性中的数据。
        peripheral.delegate = PeripheralDelegate.shared
        self.peripheral = peripheral
        
        // 连接成功后，查找服务
        peripheral.discoverServices(nil)
        
        //查找服务了
        PeripheralDelegate.shared.didDiscoverServices = { [weak self](services) in
            let vc = UIHostingController(rootView: PeripheralServicesView(services: services))
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //连接失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            print("连接失败,原因是\(error.localizedDescription)")
        }
    }
    
    //MARK: 连接断开
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            print("连接断开,原因是\(error.localizedDescription)")

        }
    }
    // 在蓝牙于后台被杀掉时，重连之后会首先调用此方法，可以获取蓝牙恢复时的各种状态
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
    }
}
 
extension BluetoothDemo: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        let model = dataArray[indexPath.row]
        config.text = "\(model.peripheral.name!)  \(model.peripheral.identifier.uuidString)"
        config.secondaryText = "信号：\(model.RSSI)"
        cell.contentConfiguration = config;
        return cell
    }
}

extension BluetoothDemo: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        //连接该蓝牙外设
        centralManager?.connect(model.peripheral, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey:true])
        //CBConnectPeripheralOptionNotifyOnDisconnectionKey
        // 应用被挂起时，系统收到蓝牙外设的通知时应当给一个警报
        // 对于没有指定蓝牙后台模式的应用来说是很有用的。如果多个应用都请求了一个蓝牙外设的通知，最近在前台的那个应用会受到这个警报
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
