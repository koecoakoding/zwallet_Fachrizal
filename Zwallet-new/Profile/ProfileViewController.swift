//
//  ProfileViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 15/08/23.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var ViewpersonalInformation: UIView!
    @IBOutlet weak var ViewChangePassword: UIView!
    @IBOutlet weak var ViewChangePin: UIView!
    @IBOutlet weak var ViewNotif: UIView!
    @IBOutlet weak var ViewLogout: UIView!
    
    
    @IBOutlet weak var switchButton: UISwitch!
    
    @IBOutlet weak var logoutLabel: UILabel!
    
    @IBOutlet weak var personalInformationView: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    var nama: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ViewpersonalInformation.layer.cornerRadius = 16
        ViewpersonalInformation.backgroundColor = UIColor(named: "Gray")
        ViewChangePassword.layer.cornerRadius = 16
        ViewChangePassword.backgroundColor = UIColor(named: "Gray")
        ViewChangePin.layer.cornerRadius = 16
        ViewChangePin.backgroundColor = UIColor(named: "Gray")
        ViewNotif.layer.cornerRadius = 16
        ViewNotif.backgroundColor = UIColor(named: "Gray")
        ViewLogout.layer.cornerRadius = 16
        ViewLogout.backgroundColor = UIColor(named: "Gray")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ApiService().getProfile { data in
            if let profileData = data {
                UserDefaults.standard.set(profileData.image, forKey: Constant.kImage)
                UserDefaults.standard.set(profileData.firstname, forKey: Constant.kFirstnameKey)
                UserDefaults.standard.set(profileData.lastname, forKey: Constant.kLastnameKey)
                UserDefaults.standard.set(profileData.phone, forKey: Constant.kPhone)
                self.setup()
                print("")
                
            } else{
                print("error")
            }
        }

    }
    
    func setup(){
        UsernameLabel.text = Constant.Firstname
        phoneNumberLabel.text = Constant.Phone
        imageProfile.kf.setImage(with:URL(string: "http://54.158.117.176:8000/\(Constant.Image)"))
    }
    
    
    @IBAction func switchNotifSlide(_ sender: Any) {
        let state = switchButton.isOn
        
        switch state{
        case true:
            ViewpersonalInformation.backgroundColor = UIColor(named: "Gray")
            ViewChangePassword.backgroundColor = UIColor(named: "Gray")
            ViewChangePin.backgroundColor = UIColor(named: "Gray")
            ViewNotif.backgroundColor = UIColor(named: "Gray")
            ViewLogout.backgroundColor = UIColor(named: "Gray")
            logoutLabel.textAlignment = .left
            logoutLabel.textColor = .black
            
        case false:
            ViewpersonalInformation.backgroundColor = UIColor.white
            ViewChangePassword.backgroundColor = UIColor.white
            ViewChangePin.backgroundColor = UIColor.white
            ViewNotif.backgroundColor = UIColor.white
            ViewLogout.backgroundColor = UIColor.white
            logoutLabel.textAlignment = .center
            logoutLabel.textColor = .red
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        ApiService().logout { data in
            
            let message = data?.message
            
            if let logout = data{
                self.showLoginViewController()
            } else {
                let alert = UIAlertController(title: "Logout Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
            
            
        }
    }
    
    
}


extension UIViewController{
    func showProfileViewController(){
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"PROFILE")
        navigationController?.pushViewController(ViewController, animated: true)
        
    }
}
