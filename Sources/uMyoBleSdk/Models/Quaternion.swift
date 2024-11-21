//
//  Quaternion.swift
//
//
//  Created by Aahil Lakhani on 11/21/24.
//

import Foundation

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
