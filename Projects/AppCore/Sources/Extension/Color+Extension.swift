//
//  Color+Extension.swift
//  AppCore
//
//  Created by abc on 3/20/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public extension Color {
    
    init(hex: String, opacity: Double = 1.0) {
        let hex = Int(hex, radix: 16)!
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
