import SwiftUI

struct LandingView: View {
    @State private var logoOpacity: Double = 0.0
    @State private var showMainApp = false
    @State private var glowIntensity: Double = 0.0  // For subtle glow fade
    
    private let fadeDuration: Double = 1.5  // Logo fade-in time
    private let totalLoadTime: Double = 4.0  // Time before transition to main app
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Clean black with faint vignette for subtle depth (no blur overload)
                RadialGradient(
                    colors: [.black, .black.opacity(0.95), .black],
                    center: .center,
                    startRadius: geometry.size.width * 0.4,
                    endRadius: geometry.size.width
                )
                .ignoresSafeArea()
                
                // Perfectly centered logo with refined glow
                Image("mainw")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)  // Exact, balanced size
                    .clipShape(Circle())
                    .opacity(logoOpacity)
                    .overlay(
                        // Subtle white glow (fades in for elegance)
                        Circle()
                            .stroke(.white.opacity(glowIntensity * 0.2), lineWidth: 2)
                            .blur(radius: 8)
                    )
                    .shadow(color: .white.opacity(glowIntensity * 0.1), radius: 12)  // Soft outer halo
                    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Pixel-perfect centering
                    .ignoresSafeArea(.container, edges: .all)
            }
            .onAppear {
                // Coordinated fade: Logo + glow
                withAnimation(.easeIn(duration: fadeDuration)) {
                    logoOpacity = 1.0
                    glowIntensity = 1.0
                }
                
                // Auto-transition to main app
                DispatchQueue.main.asyncAfter(deadline: .now() + totalLoadTime) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showMainApp = true
                    }
                }
            }
            // ... (keep your existing onAppear/timer code)

            .fullScreenCover(isPresented: $showMainApp) {  // Or rename state to $showLogin
                LoginView()  // Now to login
            }
        }
    }
}

#Preview {
    LandingView()
        .preferredColorScheme(.dark)
}
