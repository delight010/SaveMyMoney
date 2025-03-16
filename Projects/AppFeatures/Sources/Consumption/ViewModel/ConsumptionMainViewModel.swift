//
//  ConsumptionMainViewModel.swift
//  Features
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import Combine
import Foundation
import SwiftData
import SwiftUI

protocol ConsumptionMainViewModelProtocol {
    func setPlan(_ plan: Plan)
    func setConsumption(_ consumption: [Consumption])
    func getDate() -> Date
    func getDate() -> String
    func getDday() -> Int
    func getRemainBudget() -> Decimal
    func getConsumption() -> [Consumption]
    func decreaseDate()
    func increaseDate()
    func isDateSameDayAsStartDate() -> Bool
    func isDateSameDayAsToday() -> Bool
    func fetchPlan()
    func addConsumption(_ consumption: Consumption)
    func loadConsumption(consumptionID: UUID) -> Consumption?
}

public class ConsumptionMainViewModel: ObservableObject, ConsumptionMainViewModelProtocol {
    @ObservedObject private var dataManager = SwiftDataManager.shared
    
    @Published private var plan: Plan?
    @Published private var date: Date = Date()
    @Published private var remainBudget: Decimal = 0
    
    @Published var consumption: [Consumption] = []
    
    @Published var chartData: [ChartData] = [
        ChartData(label: "consumption", value: 0, color: Color.primaryColor),
        ChartData(label: "remainBudget", value: 0, color: Color.secondaryColor)
    ]
    
    private var cancellable = Set<AnyCancellable>()
    
    public init() {
        setupBinding()
        fetchPlan()
    }
    
    public func setPlan(_ plan: Plan) {
        self.plan = plan
    }
    
    internal func setConsumption(_ consumption: [Consumption]) {
        self.consumption = consumption
            .filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
            .sorted { $0.date > $1.date }
    }
    
    public func getPlan() -> Plan? {
        guard let plan = plan else { return nil }
        return plan
    }
    
    public func getDate() -> Date {
        return date
    }
    
    public func getDate() -> String {
        return DateFormatter().yearAndDay.string(from: date)
    }
    
    public func getDday() -> Int {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.day], from: Date(), to: plan?.endDate ?? Date())
        return difference.day ?? 0
    }
    
    public func getRemainBudget() -> Decimal {
        return remainBudget
    }
    
    public func getConsumption() -> [Consumption] {
        return plan?.consumption
            .filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
            .sorted { $0.date > $1.date } ?? []
    }
    
    public func decreaseDate() {
        guard let decreaseDate = Calendar.current.date(byAdding: .day, value: -1, to: date) else { return }
        date = decreaseDate
        
        if let plan = plan {
            setConsumption(plan.consumption)
        }
    }
    
    public func increaseDate() {
        guard let increaseDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { return }
        date = increaseDate
        
        if let plan = plan {
            setConsumption(plan.consumption)
        }
    }
    
    public func isDateSameDayAsStartDate() -> Bool {
        guard let plan = plan else { return false }
        let calender = Calendar.current
        return calender.isDate(date, inSameDayAs: plan.startDate)
    }
    
    public func isDateSameDayAsToday() -> Bool {
        let calender = Calendar.current
        return calender.isDate(date, inSameDayAs: Date())
    }
    
    public func fetchPlan() {
        do {
            let result: [Plan] = try dataManager.fetch(sortBy: [SortDescriptor(\.createdDate, order: .reverse)])
            if let plan = result.first {
                self.plan = plan
            }
        } catch {
            print(error)
        }
    }
    
    public func addConsumption(_ consumption: Consumption) {
        plan?.consumption.append(consumption)
    }
    
    public func loadConsumption(consumptionID: UUID) -> Consumption? {
        return plan?.consumption
            .filter { $0.id == consumptionID }
            .first
    }
    
    private func updateConsumption(_ value: Decimal) {
        chartData[0].value = value
    }
    
    private func updateRemainBudget(_ value: Decimal) {
        remainBudget = value
    }
    
    private func setupBinding() {
        $plan
            .compactMap { $0 }
            .sink { [weak self] plan in
                guard let self = self else { return }
                let totalConsumption = plan.consumption.reduce(0) { $0 + $1.amount }
                let remainBudget = plan.budget - totalConsumption
                self.setConsumption(plan.consumption)
                self.updateConsumption(totalConsumption)
                self.updateRemainBudget(remainBudget)
            }
            .store(in: &cancellable)
        
        $remainBudget
            .sink { [weak self] remainBudget in
                guard let self = self else { return }
                self.chartData[1].value = remainBudget
            }
            .store(in: &cancellable)
    }
}
