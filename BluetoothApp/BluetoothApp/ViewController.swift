//
//  ViewController.swift
//  BluetoothApp
//
//  Created by chihoooon on 2021/11/15.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    var centralManger: CBCentralManager!
    var myPeripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralManger = CBCentralManager(delegate: self, queue: nil)
    }
}


extension ViewController: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("BLE 켜짐")
            central.scanForPeripherals(withServices: nil, options: nil)
            // withServices과 options는 특정 UUID 등의 옵션을 위한 파라미터지만 nil로 설정하였을 경우 브로드캐스트로 스캔한다.
        }
        else {
            print("BLE 뭔가 문제있음")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            // 이름으로 찾는 것은 좋은 방법이 아님. 제조사ID, UUID 등을 통해서 검색하는 것이 좋음.
            print(name)
            if name == "내가 찾는 기기의 이름" {
                self.centralManger.stopScan()
                self.myPeripheral = peripheral
                self.myPeripheral.delegate = self
                
                self.centralManger.connect(peripheral, options: nil) //커넥션이 되면 밑의 didConnect 메소드가 불린다.
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // 커넥션 이후 주변기기로부터 더 많은 정보, 서비스를 얻을 수 있도록 물어보는 메소드
        self.myPeripheral.discoverServices(nil) // 앱이 백그라운드에서 주변기기를 스캔할 경우 UUID를 통해서 스캔해야함.
    }
}
