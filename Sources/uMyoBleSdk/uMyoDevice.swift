//
//  File.swift
//  
//
//  Created by Aahil Lakhani on 9/3/24.
//

import Foundation
import Combine

public class uMyoDevice: ObservableObject, Identifiable {
    public var id: UUID
    public var currentDataTime: Date
    public var currentDataID: Int
    @Published public var currentBatteryLevel: Float
    public var currentSpectrum: (sp0: Int, sp1: Int, sp2: Int, sp3: Int)
    public var currentMuscleLevel: Int
    public var currentQuaternion: (w: Int, x: Int, y: Int, z: Int)
    
    // Subject for updates
    private let updateSubject = PassthroughSubject<uMyoDevice, Never>()
    public var updates: AnyPublisher<uMyoDevice, Never> {
        updateSubject.eraseToAnyPublisher()
    }
    
    public init(id: UUID, currentDataTime: Date, currentDataID: Int, currentBatteryLevel: Float, currentSpectrum: (sp0: Int, sp1: Int, sp2: Int, sp3: Int), currentMuscleLevel: Int, currentQuaternion: (w: Int, x: Int, y: Int, z: Int)) {
        self.id = id
        self.currentDataTime = currentDataTime
        self.currentDataID = currentDataID
        self.currentBatteryLevel = currentBatteryLevel
        self.currentSpectrum = currentSpectrum
        self.currentMuscleLevel = currentMuscleLevel
        self.currentQuaternion = currentQuaternion
    }
    
    public func update(with device: uMyoDevice) {
        self.currentDataTime = device.currentDataTime
        
        if device.currentDataID < self.currentDataID % 256 {
            // Handle rollover
            self.currentDataID += 256 + (device.currentDataID - (self.currentDataID % 256))
        } else {
            // Regular update
            self.currentDataID += device.currentDataID - (self.currentDataID % 256)
        }
        
        self.currentBatteryLevel = device.currentBatteryLevel
        self.currentSpectrum = device.currentSpectrum
        self.currentMuscleLevel = device.currentMuscleLevel
        self.currentQuaternion = device.currentQuaternion
        
        // Emit the updated state
        updateSubject.send(self)
    }
    
    // Incomplete computeAngles method
    /*
    func computeAngles(from q: (w: Int, x: Int, y: Int, z: Int)) -> (roll: Float, pitch: Float, yaw: Float) {
        // Compute Roll
        let sinrCosp = 2 * (q.w * q.x + q.y * q.z)
        let cosrCosp = 1 - 2 * (q.x * q.x + q.y * q.y)
        let rollRad = atan2(sinrCosp, cosrCosp)
        let rollDeg = (180 / .pi) * rollRad
        
        // Compute Pitch
        let sinp = sqrt(1 + 2 * (q.w * q.y - q.x * q.z))
        let cosp = sqrt(1 - 2 * (q.w * q.y - q.x * q.z))
        let pitchRad = 2 * atan2(sinp, cosp) - (.pi / 2)
        let pitchDeg = (180 / .pi) * pitchRad
        
        // Compute Yaw
        let sinyCosp = 2 * (q.w * q.z + q.x * q.y)
        let cosyCosp = 1 - 2 * (q.y * q.y + q.z * q.z)
        let yawRad = atan2(sinyCosp, cosyCosp)
        let yawDeg = (180 / .pi) * yawRad
        
        return (roll: rollDeg, pitch: pitchDeg, yaw: yawDeg)
    }
     */
}
