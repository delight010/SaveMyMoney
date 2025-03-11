//
//  PlanCoordinator.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//


import Foundation

public class PlanBuildCoordinator: AppCoordinator {
    enum PlanBuildDestination: Hashable {
        case empty
        case dateRange
        case currency
        case currencyAmount
        case confirmation
    }
    
    public var appRouter: AppRouter
    
    public init(_ appRouter: AppRouter) {
        self.appRouter = appRouter
    }
}
