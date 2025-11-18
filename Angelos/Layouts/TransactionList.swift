//
//  Transaction.swift
//  Angelos
//
//  Created by BlackBird on 20/11/25.
//

import Foundation
import SwiftUI



// ------------------------------------------------------
// MARK: - Transaction List
// ------------------------------------------------------

struct TransactionList: View {

    // NOTE for backend:
    // This should be converted to a model later.
    let tx = [
        ("Savings", "Transfer", "2 hours ago", "£0.25"),
        ("M&S Football", "Pending", "2 hours ago", "£10.75"),
        ("Savings", "Transfer", "3 hours ago", "£0.39"),
        ("ASDA", "Reading", "3 hours ago", "£3.61")
    ]

    var body: some View {
        VStack(spacing: 0) {

            ForEach(tx.indices, id: \.self) { i in
                let item = tx[i]

                HStack(spacing: 14) {

                    // Leading icon with first letter
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(UIColor.systemGray5))
                        .frame(width: 52, height: 52)
                        .overlay(
                            Text(String(item.0.prefix(1)))
                                .font(.title3).bold()
                                .foregroundColor(.white)
                        )

                    // Labels
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.0)
                            .font(.headline)
                            .foregroundColor(.white)

                        Text(item.1)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(item.2)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    // Amount + Chevron
                    HStack(spacing: 6) {
                        Text(item.3)
                            .font(.headline)
                            .foregroundColor(.white)

                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }
                .padding(16)

                // Divider except last row
                if i < tx.count - 1 {
                    Divider().padding(.leading, 66)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(red: 0.11, green: 0.11, blue: 0.12))
        )
    }
}
    
