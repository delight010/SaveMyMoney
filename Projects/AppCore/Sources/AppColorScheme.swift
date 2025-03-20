//
//  AppColorScheme.swift
//  AppCore
//
//  Created by abc on 3/20/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import SwiftUI

public enum AppColorScheme: String, CaseIterable {
    case light
    case dark
    case system
    
    public var colorScheme: ColorScheme {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .light
        }
    }
}
