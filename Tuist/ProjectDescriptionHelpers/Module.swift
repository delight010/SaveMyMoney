//
//  Module.swift
//  Config
//
//  Created by abc on 3/5/25.
//

import ProjectDescription

public enum Module: CaseIterable {
    
    case app
    case features
    case ui
    case core
}

public extension Module {
    
    var name: String {
        switch self {
        case .app:
            return AppConfiguration.appName
        case .features:
            return "AppFeatures"
        case .ui:
            return "AppUI"
        case .core:
            return "AppCore"
        }
    }
    
    var path: Path {
        return .relativeToRoot("Projects/\(name)")
    }
    
    var bundleId: String {
        switch self {
        case .app:
            return AppConfiguration.bundleIdentifier
        default:
            return "\(AppConfiguration.bundleIdentifier).\(name)".lowercased()
        }
    }
    
    var baseSettings: [String: SettingValue] {
        return [
            "LOCALIZATION_PREFERS_STRING_CATALOGS": "YES",
            "LOCALIZED_STRING_SWIFTUI_SUPPORT": "YES"
        ]
    }
}
