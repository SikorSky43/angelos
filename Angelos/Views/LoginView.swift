import SwiftUI

struct LoginView: View {

    @StateObject private var vm = LoginService()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 32) {
                    Spacer()

                    VStack(spacing: 6) {
                        Text("Sign in with your account to access\nAngelos services.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .font(.callout)
                    }

                    VStack(spacing: 16) {
                        TextField("Name", text: $vm.name)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .foregroundColor(.white)
                            .cornerRadius(12)

                        SecureField("Password", text: $vm.password)
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 28)

                    Button { } label: {
                        Text("Forgot password?")
                            .foregroundColor(.blue)
                            .font(.callout)
                    }

                    liquidGlassButton

                    Spacer()
                }
                .padding(.horizontal, 28)
            }
            .alert("Login Status", isPresented: $vm.showMessage) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm.messageText)
            }
            .navigationDestination(isPresented: $vm.isLoggedIn) {
                DashboardView()
            }
        }
    }

    // MARK: - Button
    private var liquidGlassButton: some View {
        Button {
            vm.login()
        } label: {
            HStack {
                if vm.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.trailing, 8)
                }
                Text(vm.isLoading ? "Logging in..." : "Continue")
                    .font(.headline.bold())
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    )
                    .shadow(color: Color.white.opacity(0.12), radius: 12, x: 0, y: 8)
            )
        }
        .padding(.horizontal, 28)
        .disabled(vm.isLoading)
    }
}
