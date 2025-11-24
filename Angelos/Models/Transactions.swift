import Foundation

nonisolated struct Transaction: Codable, Identifiable {
    let userid = UUID()               // <-- local ID for SwiftUI
    let type: String
    let date: String
    let wallet_address: String
    let asset: String
    let amount: String
    

    enum CodingKeys: String, CodingKey {
        case type, date, time, deposit, assests
    }
}
