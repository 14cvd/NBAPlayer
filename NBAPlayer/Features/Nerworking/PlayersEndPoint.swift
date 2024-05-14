//
//  PlayersEndPoint.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import Foundation

public enum EndPoints{
    public enum PlayersEndPoint {
        case getPlayer(String) , getPlayers
    }
}


public struct Router {
    public static func url (with endPoint : EndPoints.PlayersEndPoint) -> URL? {
        
        guard let baseUrl = URL(string: "https://api.balldontlie.io") else {
            return nil
        }
        switch endPoint {
        case .getPlayers :
            return baseUrl.appendingPathComponent("/v1/players")
            
        case let .getPlayer(playerId):
            return baseUrl.appendingPathComponent("/v1/players/\(playerId)")
            
        }
        
    }
}
