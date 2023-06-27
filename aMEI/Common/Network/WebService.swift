//
//  WebService.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import Combine

class WebService{
    
    public static func call(path: EndPoint,
                            method: Method = .get,
                            completion: @escaping (Result) -> Void){
        
        call(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    static func call<T: Encodable>(path: EndPoint,
                                   method: Method = .get,
                                   body: T,
                                   completion: @escaping(Result) -> Void){
        
        guard let jsonData = try? JSONEncoder().encode(body)else { return }
        
        call(path: path.rawValue, method: method, contentType: .json, data: jsonData,  completion: completion)
    }
    
    static func call<T: Encodable>(path: String,
                                   method: Method = .get,
                                   body: T,
                                   completion: @escaping(Result) -> Void){
        
        guard let jsonData = try? JSONEncoder().encode(body)else { return }
        
        call(path: path, method: method, contentType: .json, data: jsonData,  completion: completion)
    }
    
    static func call(path: EndPoint,
                     method: Method = .get,
                     params: [URLQueryItem],
                     completion: @escaping(Result) -> Void){
        
        guard var urlRequest = completeUrl(path: path.rawValue) else{
            return
        }
        
        guard let absoluteUrl = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
        
        call(path: path.rawValue, method: method, contentType: .formUrl, data: components?.query?.data(using: .utf8),  completion: completion)
    }
    
    private static func call(path: String,
                             method: Method,
                             contentType: ContentType,
                             data: Data?,
                             completion: @escaping(Result) -> Void){
        
        guard var urlRequest = completeUrl(path: path) else{
            return
        }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink{
                userAuth in
                if let userAuth = userAuth{
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
            }
        
        //print("\(urlRequest) \n \(method.rawValue) ")
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        
        let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error
            in
            guard let data = data, error == nil else {
                print(error)
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let r = response as? HTTPURLResponse{
                switch r.statusCode{
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unauthorized, data))
                    break
                case 200:
                    completion(.success(data))
                    break
                default: break
                }
                print(r.statusCode)
            }
        }
        task.resume()
    }
    
    enum Method: String{
        case get
        case post
        case put
        case delete
    }
    
    enum NetworkError{
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result{
        case success(Data?)
        case failure(NetworkError, Data?)
    }
    
    enum EndPoint: String{
        case base = "https://h-apigateway.conectagov.estaleiro.serpro.gov.br"
        case consultaCNPJ = "/api-cnpj-empresa/v2/empresa/%d"
        case token = "/oauth2/jwt-token"
        
    }
    
    enum ContentType: String{
        case json = "application/json"
        case formUrl = "clientCredentials"
    }
    
    private static func completeUrl(path: String) -> URLRequest?{
        guard let url = URL(string: "\(EndPoint.base.rawValue)\(path)")
        else {return nil}
        return URLRequest(url: url)
    }
    
    
}
