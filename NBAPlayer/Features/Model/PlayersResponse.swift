//
//  PlayersResponse.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import Foundation

struct PlayersResponse: Codable {
    let data: [Player]
    let meta: Meta
}


