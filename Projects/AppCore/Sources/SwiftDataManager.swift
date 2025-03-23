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
public class SwiftDataManager: ObservableObject {
    public static let shared = SwiftDataManager()
    
    @Published var error: Error? = nil
    
    internal var modelContext: ModelContext? = nil
    internal var modelContainer: ModelContainer? = nil
    
    enum SwiftDataError: LocalizedError {
        case nilContext
        case fetchFailed
        case deleteFailed
        case updateFailed
        case insertFailed
        
        var errorDescription: String? {
            switch self {
            case .nilContext:
                return "Model context is nil"
            case .fetchFailed:
                return "Failed to fetch data"
            case .deleteFailed:
                return "Failed to delete data"
            case .updateFailed:
                return "Failed to update data"
            case .insertFailed:
                return "Failed to insert data"
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
    
    public func fetch<T: PersistentModel>(
        predicate: Predicate<T>? = nil,
        sortBy: [SortDescriptor<T>]? = nil
    ) throws -> [T] {
        return try performContextOperation { context in
            let descriptor = FetchDescriptor<T>(
                predicate: predicate,
                sortBy: sortBy ?? []
            )
            
            do {
                return try context.fetch(descriptor)
            } catch {
                throw SwiftDataError.fetchFailed
            }
        }
    }
    
    public func insert<T: PersistentModel>(_ item: T) throws {
        try performContextOperation { context in
            context.insert(item)
        }
    }
    
    public func update() throws {
        try performContextOperation { context in
            try context.save()
        }
    }
    
    public func delete<T: PersistentModel>(_ item: T) throws {
        try performContextOperation { context in
            context.delete(item)
            try context.save()
            return ()
        }
    }
    
    @discardableResult
    func performContextOperation<T>(_ operation: (ModelContext) throws -> T) throws -> T {
        guard let context = modelContext else {
            handleError(SwiftDataError.nilContext)
            throw SwiftDataError.nilContext
        }
        
        do {
            let result = try operation(context)
            return result
        } catch {
            handleError(error)
            throw error
        }
    }
    
    func handleError(_ error: Error) {
        print("SwiftDataManager error: \(error.localizedDescription)")
        self.error = error
    }
}
