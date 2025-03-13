//
//  ConsumptionMainViewModel.swift
//  Features
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import UI
import Core

import Combine
import Foundation
import SwiftUI

protocol ConsumptionMainViewModelProtocol {
    func setPlan(_ plan: Plan)
    func getDday() -> Int
    func getDate() -> String
    func decreaseDate()
    func increaseDate()
    func isDateSameDayAsStartDate() -> Bool
    func isDateSameDayAsEndDate() -> Bool
}

public class ConsumptionMainViewModel: ObservableObject {
    @Published private var plan: Plan?
    @Published private var date: Date = Date()
    
    public init() { }
    
    public func setPlan(_ plan: Plan) {
        self.plan = plan
    }
    
    public func getDday() -> Int {
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.day], from: Date(), to: plan?.endDate ?? Date())
        return difference.day ?? 0
    }
    
    public func getDate() -> String {
        return DateFormatter().yearAndDay.string(from: date)
    }
    
    public func decreaseDate() {
        guard let decreaseDate = Calendar.current.date(byAdding: .day, value: -1, to: date) else { return }
        date = decreaseDate
    }
    
    public func increaseDate() {
        guard let increaseDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { return }
        date = increaseDate
    }
    
    public func isDateSameDayAsStartDate() -> Bool {
        guard let plan = plan else { return false }
        let calender = Calendar.current
        return calender.isDate(date, inSameDayAs: plan.startDate)
    }
    
    public func isDateSameDayAsEndDate() -> Bool {
        guard let plan = plan else { return false }
        let calender = Calendar.current
        return calender.isDate(date, inSameDayAs: plan.endDate)
    }
}
