import Foundation

struct HistoryResponse: Codable {
    let status: String
    let history: [Transaction]?
}
