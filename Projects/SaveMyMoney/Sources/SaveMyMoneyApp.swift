import AppFeatures
import AppCore

import SwiftData
import SwiftUI

@main
struct SaveMyMoneyApp: App {
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView(coordinator: RootCoordinator(router))
                .environmentObject(router)
        }
        .modelContainer(for: Plan.self)
    }
}
