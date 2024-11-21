//
//  File.swift
//  
//
//  Created by Aahil Lakhani on 9/3/24.
//

import Foundation
import CoreBluetooth

public class uMyoDevicesManager: NSObject, ObservableObject {
    @Published public var devices = [uMyoDevice]()
    @Published public var bluetoothState = CBManagerState.unknown
    
    private var centralManager: CBCentralManager!
    
    private var cleanupTimer = Timer()
    
    public override init() {
        super.init()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        cleanupTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(cleanupOldDevices), userInfo: nil, repeats: true)
    }
    
    private func parse(_ data: Data, from id: UUID) {
        if data.count < 15 {
            return
        }
        
        let dataTime = Date()
        
        // Data:
        // [ dataID (1 byte) ] [ batteryLevel (1 byte) ] [ sp0 (1 byte) ] [ averageMuscleLevel (1 byte) ] [ sp1 (2 bytes) ] [ sp2 (2 bytes) ] [ sp3 (2 bytes) ] [ qw (2 bytes) ] [ qx (1 byte) ] [ qy (1 byte) ] [ qz (1 byte) ]
        let dataID = Int(data[0])
        let batteryLevel = Int(data[1])
        let sp0 = Int(data[2])<<8
        let muscleLevel = Int(data[3])
        let sp1 = (Int(data[4])<<8) | Int(data[5])
        let sp2 = (Int(data[6])<<8) | Int(data[7])
        let sp3 = (Int(data[8])<<8) | Int(data[9])
        let qw = (Int(data[10])<<8) | Int(data[11])
        let qx = Int(data[12])<<8
        let qy = Int(data[13])<<8
        let qz = Int(data[14])<<8
        
        let device = uMyoDevice(id: id, currentDataTime: dataTime, currentDataID: dataID, currentBatteryLevel: (Float(batteryLevel) / 255), currentSpectrum: Spectrum(sp0: sp0, sp1: sp1, sp2: sp2, sp3: sp3), currentMuscleLevel: muscleLevel, currentQuaternion: Quaternion(w: qw, x: qx, y: qy, z: qz))
        
        updateDevices(with: device)
    }
    
    // Updates existing device if in list, otherwise adds device to list
    private func updateDevices(with device: uMyoDevice) {
        if let index = devices.firstIndex(where: { $0.id == device.id }) {
            devices[index].update(with: device)
        } else {
            devices.append(device)
        }
    }
    
    // Removes existing device if lastDataTime > 5
    @objc private func cleanupOldDevices() {
        let currentTime = Date()
        devices.removeAll { device in
            return currentTime.timeIntervalSince(device.currentDataTime) > 5
        }
    }
    
    deinit {
        cleanupTimer.invalidate()
    }
}

extension uMyoDevicesManager: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        bluetoothState = central.state
        
        if central.state == .poweredOn {
            // Could modify firmware to use specific service UUID to optimize scanning
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Accesses local name and casts to type String
        // Returns if local name is not present or typecast fails
        guard let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String else {
            return
        }
        
        // Returns if local name is not "uMyo v2"
        if localName != "uMyo v2" {
            return
        }
        
        // Accesses manufacturer data and casts to type Data
        // Returns if manufacturer data is not present or typecast fails
        guard let data = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data else {
            return
        }
        
        parse(data, from: peripheral.identifier)
        
    }
}
