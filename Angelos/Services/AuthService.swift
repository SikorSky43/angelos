import Foundation

// MARK: - Auth Service
class AuthService {

    static let shared = AuthService()
    private init() { }

    func login(name: String, password: String, completion: @escaping (Result<responsedata, Error>) -> Void) {
        guard let url = URL(string: "https://angeloscapital.com/api/login.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "name": name,
            "password": password
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "No data", code: -1))) }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(responsedata.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }

    // ------------------------------------------------------
    // MARK: - LOGOUT HANDLER (NEW)
    // ------------------------------------------------------
    func logout(completion: (() -> Void)? = nil) {
        LogoutService.shared.logout()
        completion?()
    }
}
