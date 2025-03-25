//
//  SettingCoordinator.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Foundation

public class SettingCoordinator: AppCoordinator {
    public enum SettingDestination: Hashable, CaseIterable, Identifiable {
        case appearance
        case reset
        case resetSuccess
        
        public var id: Self { self }
        
        var icon: String {
            switch self {
            case .appearance:
                return "circle.lefthalf.filled"
            case .reset:
                return "arrow.triangle.2.circlepath"
            default:
                return ""
            }
        }
        
        var title: String {
            switch self {
            case .appearance:
                return "appearance_setting".localized(in: .module)
            case .reset:
                return "reset".localized(in: .module)
            default:
                return ""
            }
        }
    }
    
    public var appRouter: AppRouter
    
    public init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
