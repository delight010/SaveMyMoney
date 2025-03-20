//
//  GaugeView.swift
//  AppUI
//
//  Created by abc on 3/20/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import SwiftUI

public struct GaugeView: View {
    @State private var current: Double
    @State private var label: String = ""
    @State private var color: Color
    @State private var systemImage: String
    
    @State private var min: Double = 0.0
    @State private var max: Double = 100.0
    
    public init(current: Decimal, label: String, color: Color = .blue, systemImage: String = "") {
        self.current = current.doubleValue
        self.label = label
        self.color = color
        self.systemImage = systemImage
    }
    
    public init(current: Double, label: String, color: Color = .blue, systemImage: String = "") {
        self.current = current
        self.label = label
        self.color = color
        self.systemImage = systemImage
    }
    
    public var body: some View {
        Gauge(value: current, in: min...max) {
            if systemImage.isEmpty {
                Text(label)
            } else {
                Label(label, systemImage: systemImage)
            }
        } currentValueLabel: {
            Text(String(format: "%.0f%%", current))
        } // Gauge
        .gaugeStyle(.accessoryCircular)
        .tint(Gradient(colors: [color, Color.clear]))
    }
}

#Preview {
    GaugeView(current: 20.0, label: "Food", systemImage: "fork.knife")
}
