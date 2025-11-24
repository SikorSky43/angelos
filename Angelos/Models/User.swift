//
//  user.swift
//  test
//
//  Created by BlackBird on 20/11/25.
//

import Foundation

struct user: Codable {
    let id: Int?
    let name: String?                // ← Laravel returns null
    let email: String
    let wallet_address: String?
    let card_balance: String
    let investment_balance: String
}
