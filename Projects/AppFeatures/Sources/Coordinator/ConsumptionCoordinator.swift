//
//  ConsumptionCoordinator.swift
//  Features
//
//  Created by abc on 3/14/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Foundation

public class ConsumptionCoordinator: AppCoordinator {
    enum ConsumptionDestination: Hashable {
        case add
        case edit
    }
    
    public var appRouter: AppRouter
    
    public init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
