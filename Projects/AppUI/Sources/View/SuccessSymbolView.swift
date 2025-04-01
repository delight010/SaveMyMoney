//
//  SuccessSymbolView.swift
//  AppUI
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct SuccessSymbolView: View {
    @State private var isPresented: Bool = false
    
    public init() { }
    
    public var body: some View {
        ZStack {
            CircleAnimationView()
            Image(systemName: "trophy")
                .font(.system(size: 130))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.orange, .yellow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .symbolEffect(.pulse, options: .repeat(1) ,isActive: isPresented)
        } // ZStack
        .onAppear {
            isPresented.toggle()
        }
    }
}

#Preview {
    SuccessSymbolView()
}
