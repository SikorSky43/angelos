import SwiftUI

// ------------------------------------------------------
// MARK: - Dashboard Screen
// ------------------------------------------------------

struct DashboardView: View {
    @State private var showCardDetails = false
    @State private var showDepositPopup = false   // NEW POPUP STATE
    @State private var showLogoutMessage = false

    let balance = "£2,384.22"
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
                            BalanceTile(balance: balance)
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
            .toolbar { TopToolbar(showCardDetails: $showCardDetails,
                                 showDepositPopup: $showDepositPopup) } // UPDATED
        }

        // Existing CardDetails Screen
        .fullScreenCover(isPresented: $showCardDetails) {
            NavigationStack {
                CardDetailsView()
                    .transition(.move(edge: .leading))
            }
        }

        // NEW Deposit Popup
        .fullScreenCover(isPresented: $showDepositPopup) {
            DepositPopupView(showDepositPopup: $showDepositPopup)
        }
        
        .alert("Logout", isPresented: $showLogoutMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Logout successful.")
        }

    }
}
