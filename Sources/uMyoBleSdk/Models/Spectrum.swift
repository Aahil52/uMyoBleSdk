//
//  Spectrum.swift
//  
//
//  Created by Aahil Lakhani on 11/21/24.
//

import Foundation

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
