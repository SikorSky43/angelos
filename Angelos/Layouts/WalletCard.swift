//
//  WalletCard.swift
//  Angelos
//
//  Created by BlackBird on 20/11/25.
//

import Foundation
import SwiftUI


// ------------------------------------------------------
// MARK: - Wallet Card
// ------------------------------------------------------
// Note: No unnecessary modifiers. Pure layout.

struct WalletCard: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(red: 0.96, green: 0.44, blue: 0.47))
                .aspectRatio(1.586, contentMode: .fit)
                .shadow(color: .black.opacity(0.4), radius: 20, y: 10)

            Text("Angelos")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.trailing, 20)
                .padding(.top, 20)
        }
    }
}


