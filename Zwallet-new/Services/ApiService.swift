//
//  ApiNetowrk.swift
//  Zwallet-new
//
//  Created by Randy Zulfikar on 16/08/23.
//

import Foundation
import Moya

class ApiService{
    
    func login(email: String, password: String, completion: @escaping (DataLoginResponse?,Error?) -> ()) {
        
        let provider = MoyaProvider<Auth>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]
        )
        
        provider.request(.login(email: email, password: password), completion: { result in
            
            switch result{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let loginResponse = try decoder.decode(LoginResponse.self, from: result.data)
                    completion(loginResponse.data,nil)
                    
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        })
    }
    
    func signup(username: String, email: String, password: String, completion: @escaping (signupResponse?, Error?) -> ()) {
        let provider = MoyaProvider<Auth>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]
        )
        provider.request(.signup(username: username, email: email, password: password)) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let signUpResponse = try decoder.decode(signupResponse.self, from: result.data)
                    completion(signUpResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func forgotPassword(email: String, password: String, completion: @escaping (forgotPasswordResponse?, Error?) -> ()) {
        let provider = MoyaProvider<Auth>(
            plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))]
        )
        provider.request(.forgotPassword(email: email, password: password)) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let forgotPasswordResponse = try decoder.decode(forgotPasswordResponse.self, from: result.data)
                    completion(forgotPasswordResponse, nil)
                } catch let error {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getProfile(completion: @escaping (profileResponseData?) -> ()) {
        let provider = MoyaProvider<Auth>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        
        provider.request(.getProfile) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let responsGetProfile = try decoder.decode(profileResponse.self, from: result.data)
                    completion(responsGetProfile.data)
                } catch {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    
    func logout(completion: @escaping (LogoutResponse?) -> ()) {
        let provider = MoyaProvider<Auth>(plugins: [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose))])
        
        provider.request(.logout) { response in
            switch response{
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let logoutResponse = try decoder.decode(LogoutResponse.self, from: result.data)
                    completion(logoutResponse)
                } catch _ {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
}
