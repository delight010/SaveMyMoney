//
//  BasicAlertView.swift
//  UI
//
//  Created by abc on 3/12/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct BasicAlertView: View {
    @Binding var isPresented: Bool
    
    let title: String
    var message: String?
    let primaryButtonTitle: String
    let secondasryButtonTitle: String?
    let primaryButtonAction: (() -> Void)?
    let secondaryButtonAction: (() -> Void)?
    
    private var alertWidth: CGFloat {
        return UIScreen.main.bounds.width * 0.6
    }
    
    public init(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        primaryButtonTitle: String,
        secondaryButtonTitle: String? = nil,
        primaryButtonAction: ( () -> Void)? = nil,
        secondaryButtonAction: ( () -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self.title = title
        self.message = message
        self.primaryButtonTitle = primaryButtonTitle
        self.secondasryButtonTitle = secondaryButtonTitle
        self.primaryButtonAction = primaryButtonAction
        self.secondaryButtonAction = secondaryButtonAction
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Group {
                    Text(title)
                        .bold()
                    if let message {
                        Text(message)
                    }
                }
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                
                HStack {
                    Group {
                        if let secondasryButtonTitle {
                            Button {
                                isPresented.toggle()
                                secondaryButtonAction?()
                            } label: {
                                buttonText(secondasryButtonTitle)
                            }
                            .buttonStyle(CapsuleButtonStyle(false))
                        }
                        
                        Button {
                            isPresented.toggle()
                            primaryButtonAction?()
                        } label: {
                            buttonText(primaryButtonTitle)
                        }
                        .buttonStyle(CapsuleButtonStyle())
                    }
                    .frame(width: alertWidth * 0.5)
                } // HStack
            } // VStack
            .frame(width: alertWidth)
            .padding()
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        } // ZStack
        .onTapGesture {
            isPresented = false
        }
    }
}

extension BasicAlertView {
    
    func buttonText(_ text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    BasicAlertView(
        isPresented: .constant(true),
        title: "Title",
        message: "Message",
        primaryButtonTitle: "OK"
    )
}
