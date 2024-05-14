//
//  NetworkingManager.swift
//  NBAPlayer
//
//  Created by cavID on 14.05.24.
//

import Foundation


class NetworkManager {
    
   static let shared = NetworkManager()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    func fetch(completion : @escaping(Result<[Player] , NetworkError>) -> Void){
        guard let url = Router.url(with: EndPoints.PlayersEndPoint.getPlayers)else {
            completion(.failure(.badURL))
            return
        }
        
        let headers = ["Authorization": "2863eb40-a5c9-47af-911a-c2ecd9e8a649"]
        let request =  buildRequest(url: url, method: HTTPMethod.get.rawValue, headers: headers)
        
        makeAPICall(request: request, responseType: PlayersResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    private func buildRequest(url :URL , method:String, headers : [String : String]) -> URLRequest{
        var request = URLRequest(url:url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
    private func makeAPICall<T:Codable>(request : URLRequest , responseType : T.Type , completion : @escaping (Result<T,NetworkError>) -> Void){
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.httpResponseFailed(statusCode: 0)))
                return
            }
            let statusCode = httpResponse.statusCode
            
            if (200..<300).contains(statusCode) {
                if let responseData = data {
                    do {
                        
                        
                        let decodedData = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(decodedData))
                    } catch {
                        
                        
                        completion(.failure(.serializationError))
                    }
                } else {
                    
                    
                    completion(.failure(.emptyResult))
                }
            } else {
                completion(.failure(.httpResponseFailed(statusCode: statusCode)))
            }
        }
        dataTask.resume()
        
        
    }
    
    
    
    
}

