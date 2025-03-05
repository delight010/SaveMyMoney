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
            return "Features"
        case .ui:
            return "UI"
        case .core:
            return "Core"
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
}
