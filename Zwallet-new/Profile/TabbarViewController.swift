//
//  TabbarViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 16/08/23.
//

import Foundation
import UIKit

class TabbarViewController : UITabBarController{

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        ApiService().getProfile { data in
//            if let profileData = data {
//                UserDefaults.standard.set(profileData.image, forKey: Constant.kImage)
//                UserDefaults.standard.set(profileData.firstname, forKey: Constant.kFirstnameKey)
//                UserDefaults.standard.set(profileData.lastname, forKey: Constant.kLastnameKey)
//                UserDefaults.standard.set(profileData.phone, forKey: Constant.kPhone)
////                self.setup()
//                print("")
//                
//            } else{
//                print("error")
//            }
//        }
    }
        
}

extension UIViewController{
    func showTabbarViewController(){
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"TABBAR")
        navigationController?.setViewControllers([ViewController], animated: true)
        
    }
}
