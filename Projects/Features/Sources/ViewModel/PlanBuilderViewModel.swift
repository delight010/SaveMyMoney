//
//  PlanBuilderViewModel.swift
//  Features
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Core

import Combine
import SwiftUI

protocol PlanBuilderViewModelProtocol {
    func setDateRange(startDate: Date, endDate: Date)
    func setCurrency(_ currency: Currency)
    func setBudget(_ budget: Decimal)
}

class PlanBuilderViewModel: ObservableObject, PlanBuilderViewModelProtocol {
    @Published private var plan: Plan?
    @Published private var startDate = Date()
    @Published private var endDate = Date()
    @Published private var currency: Currency?
    @Published private var budget: Decimal = 0
    
    init() {}
    
    func setDateRange(startDate: Date, endDate: Date) {
        plan?.startDate = startDate
        plan?.endDate = endDate
    }
    
    func setCurrency(_ currency: Core.Currency) {
        self.currency = currency
    }
    
    func setBudget(_ budget: Decimal) {
        plan?.budget = budget
    }
}
