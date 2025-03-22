//
//  CircleAnimationView.swift
//  AppUI
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct CircleAnimationView: View {
    @State private var isRotate: Bool = false
    
    public init() { }
    
    public var body: some View {
        Circle()
            .foregroundStyle(AngularGradient(colors: [.primaryColor.opacity(0), .primaryColor.opacity(0.3), .primaryColor.opacity(0.5)], center: .center, angle: .degrees(isRotate ? 360 : 0)))
            .overlay {
                Circle()
                    .inset(by: 10)
                    .fill(.background)
            }
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    isRotate.toggle()
                }
            }
    }
}

#Preview {
    CircleAnimationView()
}
