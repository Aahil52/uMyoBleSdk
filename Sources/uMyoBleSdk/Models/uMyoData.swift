//
//  uMyoData.swift
//
//
//  Created by Aahil Lakhani on 11/21/24.
//

import Foundation

public struct uMyoData: Identifiable, Encodable {
    public let id = UUID()
    public let dataTime: Date
    public let dataID: Int
    public let spectrum: Spectrum
    public let muscleLevel: Int
    public let quaternion: Quaternion
}
