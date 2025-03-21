//
//  HistoryViewModel.swift
//  AppFeatures
//
//  Created by abc on 3/20/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import Combine
import Foundation
import SwiftData
import SwiftUI

protocol HistoryViewModelProtocol {
    func fetchPlan()
}

public class HistoryViewModel: ObservableObject, HistoryViewModelProtocol, ChartDataProtocol {
    @ObservedObject private var dataManager = SwiftDataManager.shared
    
    @Published public var plan: [Plan] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    public init() {
        setupBinding()
    }
    
    public func fetchPlan() {
        do {
            let result: [Plan] = try dataManager.fetch(sortBy: [SortDescriptor(\.createdDate, order: .reverse)])
            self.plan = result
        } catch {
            print(error)
        }
    }
    
    private func setupBinding() {
        $plan
            .compactMap { plan in
                plan.filter { $0.status != .inProgress }
            }
            .sink { [weak self] plan in
                guard let self = self else { return }
            }
            .store(in: &cancellable)
    }
}
