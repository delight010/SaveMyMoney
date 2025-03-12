//
//  AppRouter.swift
//  Core
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final public class AppRouter: ObservableObject {
    
    @Published public var path = NavigationPath()
    public var lastPath: AnyHashable?
    
    public init() {
        self.path = path
    }
    
    public func push(to destination: any Hashable) {
        path.append(destination)
    }
    
    public func pop(_ page: Int = 1) {
        path.removeLast(page)
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
}
