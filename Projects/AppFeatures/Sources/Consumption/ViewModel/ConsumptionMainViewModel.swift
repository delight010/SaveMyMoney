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
}

public class ConsumptionMainViewModel: ObservableObject {
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
    
    public func setPlan(_ plan: Plan) {
        self.plan = plan
    }
    
    private func setConsumption(_ consumption: [Consumption]) {
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
    
    private func updateConsumption(_ value: Decimal) {
        chartData[0].value = value
    }
    
    private func updateRemainBudget(_ value: Decimal) {
        remainBudget = value
    }
}
