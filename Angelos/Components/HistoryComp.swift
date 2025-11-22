import Foundation
internal import Combine

class HistoryComp: ObservableObject {

    static let shared = HistoryComp()
    private init() {}

    @Published var items: [HistoryItem] = []

    @Published var visibleCount: Int = 10
 // loadmore button func
    func loadMore() {
        visibleCount += 10
    }

    func loadHistory(wallet: String) {
        guard let url = URL(string: "https://angeloscapital.com/api/history.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["wallet_address": wallet]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in

            if let error = error {
                print("Network error:", error.localizedDescription)
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            // Debug raw JSON
            if let raw = String(data: data, encoding: .utf8) {
                print("Raw JSON:\n\(raw)")
            }

            do {
                let response = try JSONDecoder().decode(HistoryResponse.self, from: data)

                DispatchQueue.main.async {
                    if response.status == "success",
                       let history = response.history {
                        self.items = history
                    } else {
                        self.items = []
                    }
                }

            } catch {
                print("JSON decode error:", error.localizedDescription)
            }

        }.resume()
    }
}
