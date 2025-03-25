import AppFeatures
import AppCore

import FirebaseCore

import SwiftData
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct SaveMyMoneyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
