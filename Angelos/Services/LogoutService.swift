import Foundation
internal import Combine

class LogoutService: ObservableObject {
    static let shared = LogoutService()
    private init() {}

    @Published var isLoggedIn = false
    @Published var currentUser: user? = nil

    func login(user: user) {
        currentUser = user
        isLoggedIn = true
    }

    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
}
