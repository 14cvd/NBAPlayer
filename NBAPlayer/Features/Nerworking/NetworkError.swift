//
//  NetworkError.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case httpResponseFailed(statusCode: Int)
    case serializationError
    case emptyResult
}
