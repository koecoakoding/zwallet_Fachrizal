//
//  TokenConstant.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 16/08/23.
//

import Foundation

struct Constant{
    static var baseURL: String{
        return Bundle.main.infoDictionary?["http://54.158.117.176:8000"] as? String ?? ""
    }
    
    
    static let kAccessTokenKey = "AccessToken"
    static let kFirstnameKey = "firstname"
    static let kLastnameKey = "lastname"
    static let kPhone = "phone"
    static let kImage = "image"
    
    
    
    
    static var Token:String{
        return UserDefaults.standard.value(forKey: kAccessTokenKey) as? String ?? ""
    }
    
    static var Firstname:String{
        return UserDefaults.standard.value(forKey: kFirstnameKey) as? String ?? ""
    }
    
    static var Lastname:String{
        return UserDefaults.standard.value(forKey: kLastnameKey) as? String ?? ""
    }
    
    static var Phone:String{
        return UserDefaults.standard.value(forKey: kPhone) as? String ?? "0808080808"
    }

    static var Image:String{
        return UserDefaults.standard.value(forKey: kImage) as? String ?? ""
    }

//    static var token = UserDefaults.standard.value(forKey: "AccessToken")
//    static var firstname = UserDefaults.standard.value(forKey: "firstname")
//    static var lastname = UserDefaults.standard.value(forKey: "lastname")
//    static var email = UserDefaults.standard.value(forKey: "email")
//    static var phone = UserDefaults.standard.value(forKey: "phone")
//    static var image = UserDefaults.standard.value(forKey: "image")
}
