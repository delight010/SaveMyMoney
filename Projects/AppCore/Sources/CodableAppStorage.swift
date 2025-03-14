//
//  CodableAppStorage.swift
//  Core
//
//  Created by abc on 3/10/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct CodableAppStorage<Value: Codable>: DynamicProperty {
    let defaultValue: Value
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    @AppStorage private var data: Data
    
    public init(key: String, defaultValue: Value, store: UserDefaults? = nil) {
        self.defaultValue = defaultValue
        let defaultData = (try? encoder.encode(defaultValue)) ?? Data()
        self._data = AppStorage(wrappedValue: defaultData, key, store: store)
    }
    
    public init(wrappedValue defaultValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.init(key: key, defaultValue: defaultValue, store: store)
    }
    
    public var wrappedValue: Value {
        get { 
            (try? decoder.decode(Value.self, from: data)) ?? defaultValue 
        }
        
        nonmutating set {
            if let encoded = try? encoder.encode(newValue) {
                data = encoded
                debugPrint("\(newValue) saved")
            } else { 
                debugPrint("Could not encode \(newValue)") 
            }
        }
    }
    
    public var projectedValue: Binding<Value> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    func removeValue() { 
        data.removeAll() 
    }
}
