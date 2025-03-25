//
//  PlanDateRangePickerView.swift
//  Features
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore
import AppUI
import SwiftUI

public struct PlanDateRangePickerView: View {
    @EnvironmentObject private var router: AppRouter
    
    @ObservedObject private var viewModel: PlanBuilderViewModel
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
    
    private var endDateRange: ClosedRange<Date> {
        let minEndDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let maxEndDate = Calendar.current.date(byAdding: .day, value: 31, to: startDate)!
        return minEndDate...maxEndDate
    }    
    private let progress = 0.3
    
    public init(viewModel: PlanBuilderViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            ProgressView(value: progress)
                .tint(.progressBarColor)
                .padding()
            
            Text("please_set_the_period".localized(in: .module))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("start_date".localized(in: .module))
                    .bold()
                Text("\(DateFormatter().yearAndDay.string(from: startDate))")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 10)
                    .textRoundedRectangle()
                Text("end_date".localized(in: .module))
                    .bold()
                    .padding(.top, 5)
                DatePicker("", selection: $endDate, in: endDateRange, displayedComponents: .date)
                    .datePickerRectangle(endDate)
            } // VStack
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading) {
                Text("choose_budge_tracking_period".localized(in: .module))
                Text("period_range_info".localized(in: .module))
            } // VStack
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.secondary)
            .padding(.top, 5)
            
            Spacer()
            
            Button {
                viewModel.setDateRange(startDate: startDate, endDate: endDate)
                router.push(to: PlanBuildCoordinator.PlanBuildDestination.currencyAmount)
            } label: {
                Text("button_next".localized(in: .module))
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .onChange(of: startDate) { _, _ in
            updateEndDate()
        }
        .backNavagationToolbar {
            router.pop()
        }
    }
}

extension PlanDateRangePickerView {
    
    func updateEndDate() {
        if endDate < endDateRange.lowerBound {
            endDate = endDateRange.lowerBound
        } else if endDate > endDateRange.upperBound {
            endDate = endDateRange.upperBound
        }
    }
    
    func setDateRange() {
        viewModel.setDateRange(startDate: startDate, endDate: endDate)
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    PlanDateRangePickerView(viewModel: PlanBuilderViewModel())
        .environmentObject(router)
}

