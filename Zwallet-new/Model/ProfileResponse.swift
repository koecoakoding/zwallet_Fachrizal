//
//  File.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 18/08/23.
//

import Foundation

struct profileResponse : Codable{
    var status: Int
    var message: String
    var data: profileResponseData
}

struct profileResponseData : Codable{
    var firstname: String
    var lastname: String
    var email: String
    var phone: String
    var image: String
}
