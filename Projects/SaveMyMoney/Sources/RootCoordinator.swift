//
//  RootCoordinator.swift
//  SaveMyMoney
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Features

import Foundation

class RootCoordinator: AppCoordinator {
    var appRouter: AppRouter
    
    init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
