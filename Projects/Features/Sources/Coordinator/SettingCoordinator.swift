//
//  SettingCoordinator.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

public class SettingCoordinator: AppCoordinator {
    enum SettingDestination: Hashable, CaseIterable, Identifiable {
        case language
        case currency
        case appearance
        case reset
        
        var id: Self { self }
        
        var icon: String {
            switch self {
            case .language:
                return "globe"
            case .currency:
                return "creditcard.circle"
            case .appearance:
                return "circle.lefthalf.filled"
            case .reset:
                return "arrow.triangle.2.circlepath"
            }
        }
    }
    
    public var appRouter: AppRouter
    
    public init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
