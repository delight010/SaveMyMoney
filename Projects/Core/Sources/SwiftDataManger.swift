//
//  SwiftDataManger.swift
//  Core
//
//  Created by abc on 3/14/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftData
import SwiftUI

open class SwiftDataManger: ObservableObject {
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
    
    @MainActor
    public init(modelTypes: [any PersistentModel.Type], inMemory: Bool = false) {
        setupModelContainer(modelTypes: modelTypes, inMemory: inMemory)
    }
    
    @MainActor
    private func setupModelContainer(modelTypes: [any PersistentModel.Type], inMemory: Bool) {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let schema = Schema(modelTypes)
            let container = try ModelContainer(for: schema, configurations: configuration)
            
            modelContainer = container
            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true
            
            didSetupContainer()
        } catch {
            handleError(error)
        }
    }
    
    // Method to be overridden in subclasses
    @MainActor
    open func didSetupContainer() {
        // Implement in subclasses
    }
    
    public func performContextOperation(_ operation: (ModelContext) throws -> Void) {
        guard let context = modelContext else {
            handleError(SwiftDataError.nilContext)
            return
        }
        
        do {
            try operation(context)
        } catch {
            handleError(error)
        }
    }
    
    func handleError(_ error: Error) {
        print("SwiftDataManager error: \(error.localizedDescription)")
        self.error = error
    }
}
