//
//  WebService.swift
//  aMEI
//
//  Created by coltec on 12/06/23.
//

import Foundation
import Combine
import SwiftUI

class WebService{
    
    public static func call(cnpj: String,
                            method: Method = .get,
                            completion: @escaping (Result) -> Void){
        call(path: cnpj, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call(cep: String,
                            method: Method = .get,
                            completion: @escaping (Result) -> Void){
        call(path: cep, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    
    private static func call(path: String,
                             method: Method,
                             contentType: ContentType,
                             data: Data?,
                             completion: @escaping(Result) -> Void){
        
        guard var urlRequest = completeUrl(path: path) else{
            return
        }
        
        //print("\(urlRequest) \n \(method.rawValue) ")
        urlRequest.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest){ data, response, error
            in
            guard let data = data, error == nil else {
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
                case 403:
                    completion(.failure(.accessDenied, data))
                    break
                case 404:
                    completion(.failure(.notFound, data))
                    break
                case 429:
                    completion(.failure(.toManny, data))
                    break
                case 500:
                    completion(.failure(.internalError, data))
                    break
                case 200:
                    completion(.success(data))
                    break
                case 0, 1:
                    completion(.success(data))
                    break
                case 2, 3, 4, 5, 6, 7, 8:
                    completion(.failure(.newError, data))
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
        case accessDenied
        case toManny
        case internalError
        case newError
    }
    
    enum Result{
        case success(Data?)
        case failure(NetworkError, Data?)
    }
    
    enum EndPoint: String{
        case base = "https://receitaws.com.br/v1/cnpj/"
        case cep = "https://brasilapi.com.br/api/cep/v1/"
    }
    
    enum ContentType: String{
        case json = "application/json"
    }
    
    private static func completeUrl(path: String) -> URLRequest?{
        if path.count == 8{
            guard let url = URL(string: "\(EndPoint.cep.rawValue)\(path)")
            else {return nil}
            return URLRequest(url: url)
        }
        guard let url = URL(string: "\(EndPoint.base.rawValue)\(path)")
        else {return nil}
        return URLRequest(url: url)
    }
    
    
}
