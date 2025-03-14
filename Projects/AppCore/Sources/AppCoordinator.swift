//
//  AppCoordinator.swift
//  Core
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import SwiftUI

public protocol AppCoordinator {
    var appRouter: AppRouter { get }
    
    func push(to destination: any Hashable)
    func pop()
    func popToRoot()
}

public extension AppCoordinator {
    
    func push(to destination: any Hashable) {
        appRouter.push(to: destination)
    }
    
    func pop() {
        appRouter.pop()
    }
    
    func popToRoot() {
        appRouter.popToRoot()
    }
}
