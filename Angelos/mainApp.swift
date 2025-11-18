import SwiftUI

@main
struct mainApp: App {
    @StateObject var session = LogoutService.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                if session.isLoggedIn {
                    DashboardView()
                        .transition(.opacity)
                } else{
                    LoginView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.6), value: session.isLoggedIn)
        }
    }
}
