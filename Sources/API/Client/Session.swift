//
//  File.swift
//  
//
//  Created by Tomoya Hirano on 2021/05/14.
//

import Foundation

/// ```swift
/// let database = try await Session.shared.send(V1.Databases.Retrieve(id: id))
/// ```
public class Session {
    /// - returns: Session using shared URLSession.
    public static let shared: Session = Session(session: .shared)
    
    /// Basically use `Session.shared`.
    /// You can use this initializer when use custom `URLSession`.
    ///
    /// - parameters:
    ///     - session: URLSession
    public init(session: URLSession) {
        self.session = session
    }
    
    let session: URLSession
    private var authorizationToken: String?
    
    /// Authorization token setter.
    ///
    /// Only support internal integration token.
    /// ```swift
    /// session.setAuthorization("xxxxx")
    /// ```
    ///
    /// - parameters:
    ///     - token: notion authorization token
    ///
    /// https://developers.notion.com/docs/authorization
    public func setAuthorization(token: String) {
        self.authorizationToken = token
    }
    
    /// completion handler interface
    public func send<T: Request>(_ api: T, completions: @escaping (Result<T.Response, NotionError>) -> Void) {
        let request = api.makeURLRequest(authorizationToken: authorizationToken)
        session.dataTask(with: request) { data, response, error in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.iso8601Full)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let error = error {
                    throw error
                }
                
                guard let data = data else {
                    throw InternalError.unknown
                }
                
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    throw InternalError.unknown
                }
                guard 200..<300 ~= httpURLResponse.statusCode else {
                    let error = try? decoder.decode(APIError.self, from: data)
                    throw (error ?? InternalError.unknown)
                }
                
                completions(.success(try decoder.decode(T.Response.self, from: data)))
            } catch {
                switch error {
                case let apiError as APIError:
                    completions(.failure(NotionError.api(apiError)))
                default:
                    completions(.failure(NotionError.other(error)))
                }
            }
        }.resume()
    }
}

#if canImport(Combine)
import Combine

extension Session {
    @available(watchOS 6.0, *)
    @available(tvOS 13.0, *)
    @available(macOS 10.15, *)
    @available(iOS 13.0, *)
    /// Combine interface
    public func send<T: Request>(_ api: T) -> AnyPublisher<Result<T.Response, NotionError>, Never> {
        Deferred {
            Future { promise in
                self.send(api) { result in
                    switch result {
                    case let .success(response):
                        promise(.success(.success(response)))
                    case let .failure(error):
                        promise(.success(.failure(error)))
                    }
                }
            }
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}
#endif

#if compiler(>=5.5)
extension Session {
    @available(watchOS 8.0, *)
    @available(tvOS 15.0, *)
    @available(macOS 12.0, *)
    @available(iOS 15.0, *)
    /// async await interface
    public func send<T: Request>(_ api: T) async throws -> T.Response {
        let request = api.makeURLRequest(authorizationToken: authorizationToken)
        do {
            let (data, response) = try await session.data(for: request)
            
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
        } catch {
            switch error {
            case let apiError as APIError:
                throw NotionError.api(apiError)
            default:
                throw NotionError.other(error)
            }
        }
    }
}
#endif
