//
//  FailureSymbolView.swift
//  AppUI
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct FailureSymbolView: View {
    @State private var isPresented: Bool = false
    
    public init() { }
    
    public var body: some View {
        ZStack {
            CircleAnimationView()
            Image(systemName: "flag.slash")
                .font(.system(size: 130))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .indigo],
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
    FailureSymbolView()
}
