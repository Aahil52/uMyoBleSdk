//
//  File.swift
//  
//
//  Created by Aahil Lakhani on 9/3/24.
//

import Foundation
import Combine

public class uMyoDevice: ObservableObject, Identifiable {
    @Published public var id: UUID
    public var lastDataTime: Date
    public var lastDataID: Int
    @Published public var batteryLevel: Float
    public var currentSpectrum: [Int]
    public var currentMuscleLevel: Int
    public var quaternion: Quaternion
    
    // Subject for updates
    private let updateSubject = PassthroughSubject<uMyoDevice, Never>()
    public var updates: AnyPublisher<uMyoDevice, Never> {
        updateSubject.eraseToAnyPublisher()
    }
    
    /*
    struct Angles {
        var roll: Float
        var pitch: Float
        var yaw: Float
    }
    */
     
    public struct Quaternion {
        public var w: Int
        public var x: Int
        public var y: Int
        public var z: Int
        
        public init(w: Int, x: Int, y: Int, z: Int) {
            self.w = w
            self.x = x
            self.y = y
            self.z = z
        }
    }
    
    public init(id: UUID, lastDataTime: Date, lastDataID: Int, batteryLevel: Float, currentSpectrum: [Int], currentMuscleLevel: Int, quaternion: Quaternion) {
        self.id = id
        self.lastDataTime = lastDataTime
        self.lastDataID = lastDataID
        self.batteryLevel = batteryLevel
        self.currentSpectrum = currentSpectrum
        self.currentMuscleLevel = currentMuscleLevel
        self.quaternion = quaternion
    }
    
    public func update(with device: uMyoDevice) {
        self.lastDataTime = device.lastDataTime
        self.lastDataID = device.lastDataID
        self.batteryLevel = device.batteryLevel
        self.currentSpectrum = device.currentSpectrum
        self.currentMuscleLevel = device.currentMuscleLevel
        self.quaternion = device.quaternion
    }
    
    /*
    func computeAngles(from q: Quaternion) -> Angles {
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
        
        return Angles(roll: rollDeg, pitch: pitchDeg, yaw: yawDeg)
    }
     */
}
