import SwiftUI

@main
struct mainApp: App {
    @StateObject var session = LogoutService.shared
    @State private var showSplash = true   // ← Add this

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    LandingView(showSplash: $showSplash)   // ← Show splash first
                        .transition(.opacity)
                } else {
                    Group {
                        if session.isLoggedIn {
                            DashboardView()
                                .transition(.opacity)
                        } else {
                           LoginView()
                                .transition(.opacity)
                       }
                    }
                }
            }
            .animation(.easeInOut(duration: 0.6), value: showSplash)
            .animation(.easeInOut(duration: 0.6), value: session.isLoggedIn)
        }
    }
}
