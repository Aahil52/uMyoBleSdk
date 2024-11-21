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
