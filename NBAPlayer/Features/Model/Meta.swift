//
//  Meta.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import Foundation

struct Meta: Codable {
    let nextCursor: Int
    let perPage: Int

    enum CodingKeys: String, CodingKey {
        case nextCursor = "next_cursor"
        case perPage = "per_page"
    }
}
