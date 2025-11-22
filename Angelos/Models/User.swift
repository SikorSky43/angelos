//
//  user.swift
//  test
//
//  Created by BlackBird on 20/11/25.
//

import Foundation

nonisolated struct user: Codable {
    let id: Int?
    let name: String
    let amount: String
    let password: String?
    let wallet_address: String?   // ← ADD THIS

}


