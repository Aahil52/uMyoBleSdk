//
//  uMyoData.swift
//
//
//  Created by Aahil Lakhani on 11/21/24.
//

import Foundation

public struct uMyoData: Identifiable, Encodable {
    let id = UUID()
    let dataTime: Date
    let dataID: Int
    let spectrum: Spectrum
    let muscleLevel: Int
    let quaternion: Quaternion
}
