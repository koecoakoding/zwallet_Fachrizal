//
//  LoginResponse.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 16/08/23.
//

import Foundation

struct LoginResponse: Codable{
    var status: Int
    var message: String
    var data: DataLoginResponse
    
}

struct DataLoginResponse: Codable{
    var id: Int
    var email : String
    var token : String
}


