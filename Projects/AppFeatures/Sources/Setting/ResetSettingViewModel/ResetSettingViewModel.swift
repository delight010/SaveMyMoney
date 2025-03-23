//
//  ResetSettingViewModel.swift
//  AppFeatures
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Combine
import Foundation
import SwiftData
import SwiftUI

protocol ResetSettingViewModelProtocol {
    func deleteAllData()
}

class ResetSettingViewModel: ObservableObject, ResetSettingViewModelProtocol {
    @ObservedObject private var dataManager = SwiftDataManager.shared
    
    init() { }
    
    func deleteAllData() {
        do {
            try dataManager.deleteAllData(Plan.self)
        } catch {
            print(error)
        }
    }
}
