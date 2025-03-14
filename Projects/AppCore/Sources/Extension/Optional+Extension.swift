//
//  Optional+Extension.swift
//  Core
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

public extension Optional where Wrapped == AnyHashable {
    
    func isEqual<T>(_ type: T) -> Bool where T: Hashable {
        guard let a = self as? T else {
            return false
        }
        return a == type
    }
}
