import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private let session: URLSession
    private var cancellables = Set<AnyCancellable>()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch() -> AnyPublisher<[Player], NetworkError> {
        guard let url = Router.url(with: EndPoints.PlayersEndPoint.getPlayers) else {
            return Fail(error: .badURL).eraseToAnyPublisher()
        }
        
        let headers = ["Authorization": "2863eb40-a5c9-47af-911a-c2ecd9e8a649"]
        let request = buildRequest(url: url, method: HTTPMethod.get.rawValue, headers: headers)
        
        return makeAPICall(request: request, responseType: PlayersResponse.self)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest(url: URL, method: String, headers: [String: String]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func makeAPICall<T: Decodable>(request: URLRequest, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> T in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.httpResponseFailed(statusCode: 0)
                }
                
                let statusCode = httpResponse.statusCode
                
                if (200..<300).contains(statusCode) {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        return decodedData
                    } catch {
                        throw NetworkError.serializationError
                    }
                } else {
                    throw NetworkError.httpResponseFailed(statusCode: statusCode)
                }
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.requestFailed(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
