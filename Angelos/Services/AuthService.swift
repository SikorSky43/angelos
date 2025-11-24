import Foundation

class AuthService {

    static let shared = AuthService()
    private init() {}

    func login(email: String,
               password: String,
               completion: @escaping (Result<user, Error>) -> Void) {

        guard let url = URL(string: "https://angeloscapital.com/api/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "email": email,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Empty data", code: -1)))
                }
                return
            }

            // Debug Laravel JSON
            if let raw = String(data: data, encoding: .utf8) {
                print("Laravel Login JSON →", raw)
            }

            do {
                struct LaravelLoginResponse: Codable {
                    let status: String
                    let token: String
                    let user: user
                }

                let decoded = try JSONDecoder().decode(LaravelLoginResponse.self, from: data)

                // save token
                UserDefaults.standard.set(decoded.token, forKey: "auth_token")
                UserDefaults.standard.set(decoded.user.email, forKey: "email")
                UserDefaults.standard.set(decoded.user.wallet_address, forKey: "wallet_address")
                UserDefaults.standard.set(decoded.user.card_balance, forKey: "card_balance")
                UserDefaults.standard.set(decoded.user.investment_balance, forKey: "investment_balance")

                DispatchQueue.main.async {
                    completion(.success(decoded.user))
                }

            } catch {
                DispatchQueue.main.async {
                    print("JSON decode error:", error.localizedDescription)
                    completion(.failure(error))
                }
            }

        }.resume()
    }


    func logout(completion: (() -> Void)? = nil) {
        LogoutService.shared.logout()
        completion?()
    }
}
