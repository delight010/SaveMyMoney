//
//  BackgroundClearView.swift
//  UI
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

struct BackgroundClearView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
