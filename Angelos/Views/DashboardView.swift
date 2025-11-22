import SwiftUI

struct DashboardView: View {
    @State private var showCardDetails = false
    @State private var showDepositPopup = false
    @State private var showLogoutMessage = false
    @StateObject private var logoutService = LogoutService.shared
    @ObservedObject private var balanceService = Balance.shared
    @StateObject private var historycomp = HistoryComp.shared

    let status = "Updated just now"
    let activity: [Double] = [0.2, 0.5, 0.8, 1.0, 0.65, 0.55, 0.7, 0.4, 0.35, 0.3, 0.25]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    WalletCard()
                        .padding(.horizontal, 20)
                        .padding(.bottom, -6)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 12) {
                            BalanceTile(balance: balanceService.balance)
                            ActivityTile(values: activity)
                        }
                        .frame(height: 105)
                        .padding(.horizontal, 20)

                        Text(status)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading, 20)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Latest Transactions")
                            .font(.title3).bold()
                            .foregroundColor(.white)

                        TransactionList()

                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)
            }
            .background(Color.black.ignoresSafeArea())
            .toolbar {
                TopToolbar(showCardDetails: $showCardDetails,
                           showDepositPopup: $showDepositPopup,
                           onLogout: handleLogout)
            }
        }
        .fullScreenCover(isPresented: $showCardDetails) {
            NavigationStack {
                CardDetails()
                    .transition(.move(edge: .leading))
            }
        }
        .fullScreenCover(isPresented: $showDepositPopup) {
            DepositPopup(showDepositPopup: $showDepositPopup)
        }
        .alert("Logout", isPresented: $showLogoutMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Logout successful.")
        }
        .onAppear {
            let savedName = UserDefaults.standard.string(forKey: "username") ?? ""

            if !savedName.isEmpty {
                balanceService.getBalance(name: savedName)
            }
            //next for history transaction
            print("amine")
            let wallet = UserDefaults.standard.string(forKey: "wallet_address") ?? ""
            
            if !wallet.isEmpty {
                historycomp.loadHistory(wallet: wallet)
            }

        }
    }

    private func handleLogout() {
        AuthService.shared.logout {
            showLogoutMessage = true
        }
    }
}
