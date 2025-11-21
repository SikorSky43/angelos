//
//  responsedata.swift
//  test
//
//  Created by BlackBird on 20/11/25.
//

import Foundation
nonisolated struct responsedata: Codable {
    let status: String
    let message: String
    let user: user?
    
}
