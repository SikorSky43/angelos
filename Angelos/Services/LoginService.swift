import Foundation
import SwiftUI
internal import Combine

class LoginService: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var showMessage = false
    @Published var messageText = ""

    func logout() {
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "auth_token")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "wallet_address")
        UserDefaults.standard.removeObject(forKey: "card_balance")
        UserDefaults.standard.removeObject(forKey: "investment_balance")
    }

    func login() {

        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedEmail.isEmpty, !trimmedPassword.isEmpty else {
            messageText = "Please enter email and password."
            showMessage = true
            return
        }

        isLoading = true

        AuthService.shared.login(email: trimmedEmail, password: trimmedPassword) { result in
            DispatchQueue.main.async {

                self.isLoading = false

                switch result {

                case .success(let user):
                    LogoutService.shared.login(user: user)
                    self.isLoggedIn = true

                case .failure(let error):
                    self.messageText = "Login failed: \(error.localizedDescription)"
                    self.showMessage = true
                }
            }
        }
    }

    // ------------------------------------------------------
    // MARK: - Forgot Password Email
    // ------------------------------------------------------
    func sendForgotPasswordEmail() {
        let email = "Helpme@angeloscapital.com"
        let subject = "Password Reset Request"
        let body = "Hello,\n\nI need help resetting my password."

        let encoded = "mailto:\(email)?subject=\(subject)&body=\(body)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        if let url = URL(string: encoded) {
            UIApplication.shared.open(url)
        }
    }
}
