//
//  Player.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import Foundation

struct Player: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let team: Team
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case position
        case team
    }
}
