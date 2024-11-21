//
//  uMyoData.swift
//
//
//  Created by Aahil Lakhani on 11/21/24.
//

import Foundation

public struct uMyoData: Identifiable, Codable {
    public let id: UUID
    public let dataTime: Date
    public let dataID: Int
    public let spectrum: Spectrum
    public let muscleLevel: Int
    public let quaternion: Quaternion
    
    public init(id: UUID, dataTime: Date, dataID: Int, spectrum: Spectrum, muscleLevel: Int, quaternion: Quaternion) {
        self.id = id
        self.dataTime = dataTime
        self.dataID = dataID
        self.spectrum = spectrum
        self.muscleLevel = muscleLevel
        self.quaternion = quaternion
    }
}

public struct Spectrum: Codable {
    public let sp0: Int
    public let sp1: Int
    public let sp2: Int
    public let sp3: Int
    
    public init(sp0: Int, sp1: Int, sp2: Int, sp3: Int) {
        self.sp0 = sp0
        self.sp1 = sp1
        self.sp2 = sp2
        self.sp3 = sp3
    }
}


public struct Quaternion: Codable {
    public let w: Int
    public let x: Int
    public let y: Int
    public let z: Int
    
    public init(w: Int, x: Int, y: Int, z: Int) {
        self.w = w
        self.x = x
        self.y = y
        self.z = z
    }
}
