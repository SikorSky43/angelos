import Foundation


nonisolated struct HistoryResponse: Codable {
    let status: String
    let message: String
    let history: [HistoryItem]?
}
