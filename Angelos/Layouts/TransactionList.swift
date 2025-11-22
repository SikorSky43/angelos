import SwiftUI

struct TransactionList: View {
    @ObservedObject var historyComp = HistoryComp.shared
    
    var visibleHistory: [HistoryItem] {
        Array(historyComp.items.prefix(historyComp.visibleCount))
    }

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Transactions
            ForEach(visibleHistory) { item in
                HStack(spacing: 14) {

                    // Asset image instead of letter box
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 52, height: 52)
                        .overlay(
                            AsyncImage(url: URL(string: item.assests)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .tint(.white)

                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()

                                case .failure(_):
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)

                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .padding(6)
                        )


                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.type)
                            .foregroundColor(.white)
                            .font(.headline)

                    
                        Text("\(formatDate(item.date)) • Time: \(item.time)")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }

                    Spacer()

                    Text(item.deposit)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(16)

                Divider().padding(.leading, 66)
            }

            // MARK: - Load More Button
            if historyComp.visibleCount < historyComp.items.count {
                Button(action: {
                    withAnimation(.spring()) {
                        historyComp.loadMore()
                    }
                }) {
                    Text("Load More")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)  // Apple liquid glass
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                                .shadow(color: Color.white.opacity(0.15), radius: 12)
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                }
            }

        }
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 0.11, green: 0.11, blue: 0.12))
        )
    }

    // MARK: - Date Formatter (2025-01-29 → 29/1/2025)
    func formatDate(_ input: String) -> String {
        let formatterIn = DateFormatter()
        formatterIn.dateFormat = "yyyy-MM-dd"

        let formatterOut = DateFormatter()
        formatterOut.dateFormat = "d/M/yyyy"

        if let date = formatterIn.date(from: input) {
            return formatterOut.string(from: date)
        }
        return input
    }
}
