import Foundation
internal import Combine

class Balance: ObservableObject {
    static let shared = Balance()
    private init() { }
    
    @Published var balance: String = "£0.00"
    
    func getBalance(name: String) {
        guard let url = URL(string: "https://angeloscapital.com/api/balance.php") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // PHP API expects: { "name": "xxxx" }
        let body: [String: Any] = ["name": name]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            
            guard let data = data else {
              //  print("No data received")
                return
            }
           
            
            do {
                let response = try JSONDecoder().decode(responsedata.self, from: data)
                
                DispatchQueue.main.async {
                    if response.status == "success",
                       let amountStr = response.user?.amount {
                        
                        // SHOW EXACT STRING FROM DATABASE
                        self.balance = "£" + amountStr
                        
                    } else {
                    //    print("API returned error:", response.message)
                        self.balance = "£0.00"
                    }
                }
                
            } catch {
               // print("JSON decode error:", error.localizedDescription)
                DispatchQueue.main.async {
                    self.balance = "£0.00"
                }
            }
            
        }.resume()
    }
}
