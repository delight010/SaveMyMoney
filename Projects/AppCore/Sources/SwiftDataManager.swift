//
//  SwiftDataManager.swift
//  Core
//
//  Created by abc on 3/14/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftData
import SwiftUI

@MainActor
public final class SwiftDataManager: ObservableObject {
    public static let shared = SwiftDataManager()
    
    @Published var error: Error? = nil
    
    internal var modelContext: ModelContext? = nil
    internal var modelContainer: ModelContainer? = nil
    
    enum SwiftDataError: LocalizedError {
        case nilContext
        
        var errorDescription: String? {
            switch self {
            case .nilContext:
                return "Model context is nil"
            }
        }
    }
    
    public init() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            let schema = Schema([Plan.self, Consumption.self])
            let container = try ModelContainer(for: schema, configurations: configuration)
            
            modelContainer = container
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
        } catch {
            handleError(error)
        }
    }
    
    func handleError(_ error: Error) {
        print("SwiftDataManager error: \(error.localizedDescription)")
        self.error = error
    }
}
