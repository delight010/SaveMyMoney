import AppFeatures
import AppCore

import SwiftData
import SwiftUI

@main
struct SaveMyMoneyApp: App {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("appColorScheme") private var appColorScheme: AppColorScheme = .system
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView(coordinator: RootCoordinator(router))
                .environmentObject(router)
                .preferredColorScheme(appColorScheme == .system ? nil : appColorScheme.colorScheme)
        }
        .modelContainer(for: Plan.self)
    }
}
