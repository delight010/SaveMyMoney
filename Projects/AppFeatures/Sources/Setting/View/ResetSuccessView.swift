//
//  ResetSuccessView.swift
//  AppFeatures
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftUI

public struct ResetSuccessView: View {
    @EnvironmentObject private var router: AppRouter
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("reset_success_message")
            Text("return_to_initial_setup")

            Button("Go to main") {
                router.popToRoot()
            }
            .buttonStyle(CapsuleButtonStyle())
        } // VStack
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResetSuccessView()
}
