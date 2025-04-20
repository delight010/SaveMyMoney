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
    public enum ConsumptionDestination: Hashable {
        case add
        case edit(consumptionID: UUID)
        case success
        case failure
    }
    
    public var appRouter: AppRouter
    
    public init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
