import SwiftUI

struct CardDetails: View {
    @Environment(\.dismiss) var dismiss   // ← needed to close the sheet

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {

            // MARK: - Add Physical Card Button
            Button(action: {}) {
                Text("Add Physical Card Information")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 0.14, green: 0.14, blue: 0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            }

            // MARK: - Paragraph 1
            Text("""
Apple may use the last four digits of your physical card to help you identify transactions. Your full card number, expiration date, and security code are encrypted and stored in your iCloud Keychain. They are visible only to you and are not used for Apple Pay transactions.
""")
            .font(.body)
            .foregroundColor(.gray)
            .padding(.horizontal, 4)

            Spacer()

            // MARK: - Paragraph 2
            Text("""
Use the last four digits to identify Apple Pay transactions made with this card. This number is unique to this device.
""")
            .font(.body)
            .foregroundColor(.gray)
            .padding(.horizontal, 4)

            Spacer(minLength: 80)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .navigationTitle("Card Numbers")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()      // ← closes the screen
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}
