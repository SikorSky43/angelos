import SwiftUI

struct TopToolbar: ToolbarContent {

    @Binding var showCardDetails: Bool
    @Binding var showDepositPopup: Bool
    let onLogout: () -> Void   // NEW CALLBACK

    var body: some ToolbarContent {

        // PLUS → OPEN DEPOSIT POPUP
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                withAnimation(.spring()) {
                    showDepositPopup = true
                }
            } label: {
                Image(systemName: "plus")
            }
        }

        ToolbarItemGroup(placement: .navigationBarTrailing) {

            Button {
                withAnimation(.easeInOut(duration: 0.28)) {
                    showCardDetails = true
                }
            } label: {
                Image(systemName: "creditcard")
            }

            Button {} label: {
                Image(systemName: "magnifyingglass")
            }

            // LOGOUT BUTTON
            Button {
                onLogout()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.title2)
                    .foregroundColor(.white)
            }
        }
    }
}
