//
//  PlanConfirmationView.swift
//  Features
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore
import AppUI
import SwiftUI

public struct PlanConfirmationView: View {
    @EnvironmentObject private var router: AppRouter
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @ObservedObject private var viewModel: PlanBuilderViewModel
    
    @State private var isShowingAlert: Bool = false
    
    private let progress = 1.0
    
    public init(viewModel: PlanBuilderViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            ProgressView(value: progress)
                .tint(.progressBarColor)
                .padding()
            
            Text("review_your_entries".localized(in: .module))
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            
            ScrollView {
                inputPlanView()
                challengeInfoView()
                successInfoView()
                failureInfoView()
            }
            
            Spacer()
            
            Button {
                isShowingAlert.toggle()
            } label: {
                Text("done".localized(in: .module))
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .backNavagationToolbar {
            router.pop()
        }
        .basicAlert(isPresented: $isShowingAlert,
                    title: "challenge_start".localized(in: .module),
                    message: "plan_confirmation_message".localized(in: .module),
                    primaryButtonTitle: "button_ok".localized(in: .module),
                    secondaryButtonTitle: "button_cancel".localized(in: .module)) {
            viewModel.insertPlan()
            saveCurrency()
            router.popToRoot()
        } secondaryButtonAction: { }
    }
}

// MARK: Functions

extension PlanConfirmationView {
    
    func saveCurrency() {
        if let selectedCurrency = viewModel.getCurrency() {
            currency = selectedCurrency
        }
    }
}


// MARK: UI Components

extension PlanConfirmationView {
    
    func inputPlanView() -> some View {
        VStack {
            HStack {
                Text("start_date".localized(in: .module))
                Spacer()
                Text("\(viewModel.getStartDate())")
            }
            Divider()
            HStack {
                Text("end_date".localized(in: .module))
                Spacer()
                Text("\(viewModel.getEndDate())")
            }
            Divider()
            HStack {
                Text("currency".localized(in: .module))
                Spacer()
                Text("\(viewModel.getCurrency())")
            }
            Divider()
            HStack {
                Text("budget".localized(in: .module))
                Spacer()
                Text("\(viewModel.getBudget())")
            }
        } // VStack
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.secondaryColor.opacity(0.3))
        }
    }
    
    func challengeInfoView() -> some View {
        VStack {
            Group {
                Label {
                    Text("\(viewModel.calculateDateDifference()) "
                        .appending("calculate_date_info".localized(in: .module)))
                        .font(.title3)
                        .bold(true)
                } icon: {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundStyle(Color.pressedButtonBackground)
                }
                Divider()
                Text("budget_commitment_confirmation".localized(in: .module))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                Text("warning_no_changes_after_confirm".localized(in: .module))
            } // Group
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(nil)
        } // VStack
        .padding()
        .backgroundRoundedRectangle()
    }
    
    func successInfoView() -> some View {
        VStack {
            Group {
                Label {
                    Text("success_uppercase".localized(in: .module))
                        .font(.title3)
                        .bold(true)
                } icon: {
                    Image(systemName: "checkmark.diamond.fill")
                        .foregroundStyle(Color.primaryColor)
                }
                Divider()
                Text("success_condition".localized(in: .module))
            } // Group
            .frame(maxWidth: .infinity, alignment: .leading)
        } // VStack
        .padding()
        .backgroundRoundedRectangle()
    }
    
    func failureInfoView() -> some View {
        VStack {
            Group {
                Label {
                    Text("failure_uppercase".localized(in: .module))
                        .font(.title3)
                        .bold(true)
                } icon: {
                    Image(systemName: "xmark.diamond.fill")
                        .foregroundStyle(Color.disabledButtonText)
                }
                Divider()
                Text("failure_condition".localized(in: .module))
            } // Group
            .frame(maxWidth: .infinity, alignment: .leading)
        } // VStack
        .padding()
        .backgroundRoundedRectangle()
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    PlanConfirmationView(viewModel: PlanBuilderViewModel())
        .environmentObject(router)
}
