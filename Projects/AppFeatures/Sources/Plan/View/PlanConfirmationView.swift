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
    @EnvironmentObject var router: AppRouter
    
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
            
            Text("Review Your Entries")
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
                Text("Done")
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .backNavagationToolbar {
            router.pop()
        }
        .basicAlert(isPresented: $isShowingAlert,
                    title: "Challenge Start",
                    message: "Ready to start your budgeting journey?",
                    primaryButtonTitle: "OK",
                    secondaryButtonTitle: "Cancel") {
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
                Text("Start Date")
                Spacer()
                Text("\(viewModel.getStartDate())")
            }
            Divider()
            HStack {
                Text("End Date")
                Spacer()
                Text("\(viewModel.getEndDate())")
            }
            Divider()
            HStack {
                Text("Currency")
                Spacer()
                Text("\(viewModel.getCurrency())")
            }
            Divider()
            HStack {
                Text("Budget")
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
                    Text("\(viewModel.calculateDateDifference()) days challenge")
                        .font(.title3)
                        .bold(true)
                } icon: {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundStyle(Color.pressedButtonBackground)
                }
                Divider()
                Text("You're committing to this budget for the specified period.")
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                Text("Period and amount cannot be changed after confirmation.")
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
                    Text("SUCCESS")
                        .font(.title3)
                        .bold(true)
                } icon: {
                    Image(systemName: "checkmark.diamond.fill")
                        .foregroundStyle(Color.primaryColor)
                }
                Divider()
                Text("If you have money left on the day after end date.")
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
                    Text("FAILURE")
                        .font(.title3)
                        .bold(true)
                } icon: {
                    Image(systemName: "xmark.diamond.fill")
                        .foregroundStyle(Color.disabledButtonText)
                }
                Divider()
                Text("If you spend your entire budget before end date.")
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
