import Foundation
import SwiftUI
internal import Combine

class LoginService: ObservableObject {

    @Published var name: String = ""
    @Published var password: String = ""

    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var showMessage = false
    @Published var messageText = ""
    
    func logout() {
        isLoggedIn = false
    }

    func login() {

        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty, !trimmedPassword.isEmpty else {
            messageText = "Please enter name and password."
            showMessage = true
            return
        }

        isLoading = true

        AuthService.shared.login(name: trimmedName, password: trimmedPassword) { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let response):
                    if response.status == "success", let user = response.user {

                        // 🔥 SAVE USERNAME SO DASHBOARD CAN LOAD BALANCE
                        UserDefaults.standard.set(user.name, forKey: "username")
                        
                        // SAVE WALLET ADDRESS HERE
                        UserDefaults.standard.set(user.wallet_address ?? "", forKey: "wallet_address")

                        // Save user globally
                        LogoutService.shared.login(user: user)

                        self.isLoggedIn = true

                    }
                    
                    else {
                        self.messageText = "Login failed: \(response.message)"
                        self.showMessage = true
                    }

                case .failure(let error):
                    self.messageText = "Error: \(error.localizedDescription)"
                    self.showMessage = true
                }
            }
        }
    }

    // ------------------------------------------------------
    // MARK: - Forgot Password Email Function (NEW)
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
