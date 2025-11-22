import Foundation

nonisolated struct HistoryItem: Codable, Identifiable {
    let id = UUID()               // <-- local ID for SwiftUI
    let type: String
    let date: String
    let time: String
    let deposit: String
    let assests: String
    

    enum CodingKeys: String, CodingKey {
        case type, date, time, deposit, assests
    }
}
