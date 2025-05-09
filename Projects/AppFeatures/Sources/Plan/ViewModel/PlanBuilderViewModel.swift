//
//  PlanBuilderViewModel.swift
//  Features
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Combine
import SwiftUI

protocol PlanBuilderViewModelProtocol {
    func setDateRange(startDate: Date, endDate: Date)
    func setCurrency(_ currency: Currency)
    func setBudget(_ budget: Decimal)
    func getStartDate() -> String
    func getEndDate() -> String
    func getCurrency() -> String
    func getCurrency() -> Currency?
    func getBudget() -> String
    func calculateDateDifference() -> Int
    func isSwiftDataPlanEmpty() -> Bool
    func createPlan() -> Plan
    func insertPlan()
}

public class PlanBuilderViewModel: ObservableObject, PlanBuilderViewModelProtocol {
    @ObservedObject private var dataManager = SwiftDataManager.shared
    
    @Published private var startDate = Date()
    @Published private var endDate = Date()
    @Published private var currency: Currency?
    @Published private var budget: Decimal = 0
    
    public init() {}
    
    func setDateRange(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func setCurrency(_ currency: AppCore.Currency) {
        self.currency = currency
    }
    
    func setBudget(_ budget: Decimal) {
        self.budget = budget
    }
    
    func getStartDate() -> String {
        return DateFormatter().yearAndDay.string(from: startDate)
    }
    
    func getEndDate() -> String {
        return DateFormatter().yearAndDay.string(from: endDate)
    }
    
    func getCurrency() -> String {
        guard let currency = self.currency else { return "" }
        return "\(currency.flag) \(currency.code)"
    }
    
    func getCurrency() -> Currency? {
        return currency
    }
    
    func getBudget() -> String {
        guard let currency = self.currency else { return "" }
        return currency.formatStyle().format(budget)
    }
    
    func calculateDateDifference() -> Int {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.day], from: startDate, to: endDate)
        return difference.day ?? 0
    }
    
    func isSwiftDataPlanEmpty() -> Bool {
        do {
            let result: [Plan] = try dataManager.fetch(sortBy: [SortDescriptor(\.createdDate, order: .reverse)])
            return result.isEmpty
        } catch {
            print(error)
        }
        return true
    }
    
    func createPlan() -> Plan {
        return Plan(startDate: startDate, endDate: endDate, budget: budget, consumption: [])
    }
    
    func insertPlan() {
        let plan = createPlan()
        do {
            try dataManager.insert(plan)
        } catch {
            print(error)
        }
    }
}
