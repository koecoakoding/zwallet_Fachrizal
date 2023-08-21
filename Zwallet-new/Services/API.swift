//
//  API.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 16/08/23.
//

import Foundation
import Moya

enum Auth{
    case login(email: String, password: String)
    case signup(username:String, email: String, password: String)
    case forgotPassword(email: String, password: String)
    case logout
    case getProfile
    
}

extension Auth: TargetType{
    var baseURL: URL {
        return URL(string: "http://54.158.117.176:8000")!
    }
    
    var path: String {
        switch self{
        case .login:
            return "/auth/login"
        case .signup:
            return "/auth/signup"
        case .forgotPassword:
            return "/auth/reset"
        case .logout:
            return "/auth/logout/\(Constant.Token)"
        case .getProfile:
            return "/user/myProfile"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case.login, .signup:
            return .post
        case .forgotPassword:
            return .patch
        case .logout:
            return .delete
        case .getProfile:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .login(email: let email, password: let password):
            return .requestParameters(parameters: ["email" : email, "password" : password], encoding: URLEncoding .default)
        case .signup(username: let username, email: let email, password: let password):
            return .requestParameters(parameters: ["username" : username, "email": email, "password": password], encoding: URLEncoding .default)
        case .forgotPassword(email: let email, password: let password):
            return .requestParameters(parameters: ["email" : email, "password" : password], encoding: URLEncoding .default)
        case .logout, .getProfile:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .login, .signup, .forgotPassword:
            return nil
        case .getProfile, .logout:
            return ["Authorization": "Bearer \(Constant.Token)"]
        }
    }
    
    
}
