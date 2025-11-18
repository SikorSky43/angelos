//
//  BlanceTile.swift
//  Angelos
//
//  Created by BlackBird on 20/11/25.
//

import Foundation
import SwiftUI
// ------------------------------------------------------
// MARK: - Balance Tile
// ------------------------------------------------------

struct BalanceTile: View {
    let balance: String

    var body: some View {
        VStack {
            Text("Available Balance")
                .font(.headline)
                .foregroundColor(.white.opacity(0.95))
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 0)

            Text(balance)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .minimumScaleFactor(0.8)

            Spacer(minLength: 0)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(red: 0.11, green: 0.11, blue: 0.12))
        )
    }
}
