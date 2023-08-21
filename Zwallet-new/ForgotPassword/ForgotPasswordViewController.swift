//
//  ForgotPasswordViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 14/08/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var imageEmail: UIImageView!
    @IBOutlet weak var emailSeparator: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        emailTextField.delegate = self
        
    }
    
    func setup(){
        
        confirmButton.isEnabled = false
        imageEmail.tintColor = UIColor(named: "InitialGray")
        emailSeparator.backgroundColor = UIColor(named: "InitialGray")
        
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"NEWPASS") as? NewPasswordViewController
        
        ViewController?.email = (self.emailTextField.text)!
        navigationController?.pushViewController(ViewController!, animated: true)
    }
    
    
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
        
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case emailTextField:
            imageEmail.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")
        default: break
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField{
        case emailTextField:
            if !(textField.text ?? "").isEmpty{
                imageEmail.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                imageEmail.tintColor = UIColor(named: "InitialGray")
                emailSeparator.backgroundColor = UIColor(named: "InitialGray")
            }
        default:break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
//        
        switch textField{
        case emailTextField:
            let returnBool = isEmailValid(email: emailTextField.text ?? "")
            confirmButton.isEnabled = returnBool
        default:
            break
        }
        return true
    }
}

extension UIViewController{
    func showResetViewController(){
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:"RESET")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

