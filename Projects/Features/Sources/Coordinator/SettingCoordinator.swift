//
//  SettingCoordinator.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

class SettingCoordinator: AppCoordinator {
    enum SettingDestination: Hashable {
        case language
        case currency
        case appearance
        case reset
    }
    
    var appRouter: AppRouter
    
    init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
