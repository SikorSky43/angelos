//
//  Balance.swift
//  Angelos
//
//  Created by BlackBird on 21/11/25.
//

import Foundation
internal import Combine
class Balance: ObservableObject {
    static let shared = Balance()
    private init() {}

    @Published var balance: String = "£0.00"

    func GetBalance() {
        guard let url = URL(string: "https://angeloscapital.com/api/login.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Balance error:", error)
                return
            }

            guard let data = data else {
                print("No balance data")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(responsedata.self, from: data)

                DispatchQueue.main.async {
              //      self.balance = decoded.user?.amount ?? "£0.00"
                }

            } catch {
                print("Decode error:", error)
            }
        }.resume()
    }
}
