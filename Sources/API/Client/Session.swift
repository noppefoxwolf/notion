//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation
import Combine

public class Session {
    public static let shared: Session = Session(session: .shared)
    
    public init(session: URLSession) {
        self.session = session
    }
    
    let session: URLSession
    private var authorizationToken: String?
    
    public func setAuthorization(token: String) {
        self.authorizationToken = token
    }
    
    public func send<T: Request>(_ api: T) -> AnyPublisher<Result<T.Response, NotionError>, Never> {
        let request = api.makeURLRequest(authorizationToken: authorizationToken)
        return session.dataTaskPublisher(for: request)
            .tryMap({ (data, response) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.iso8601Full)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    throw InternalError.unknown
                }
                guard 200..<300 ~= httpURLResponse.statusCode else {
                    let error = try? decoder.decode(APIError.self, from: data)
                    throw (error ?? InternalError.unknown)
                }
                
                return try decoder.decode(T.Response.self, from: data)
            })
            .map(Result.success)
            .catch({ (error) -> Just<Result<T.Response, NotionError>> in
                switch error {
                case let apiError as APIError:
                    return Just(.failure(NotionError.api(apiError)))
                default:
                    return Just(.failure(NotionError.other(error)))
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
