//
//  SignUpViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 14/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameSeparator: UIView!
    
    
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailSeparator: UIView!
    
    @IBOutlet weak var imagePassword: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordViewSeparator: UIView!
    @IBOutlet weak var passwordEyeButton: UIButton!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        separatorLoginButton()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setup(){
        imagePassword.tintColor = UIColor(named: "InitialGray")
        emailImage.tintColor = UIColor(named: "InitialGray")
        usernameImage.tintColor = UIColor(named: "InitialGray")
        emailSeparator.backgroundColor = UIColor(named: "InitialGray")
        passwordViewSeparator.backgroundColor = UIColor(named: "InitialGray")
        usernameSeparator.backgroundColor = UIColor(named: "InitialGray")
        passwordEyeButton.tintColor = UIColor(named: "InitialGray")
        
        signUpButton.isEnabled = false
    }
    
    func separatorLoginButton(){
        let text1 = "Already have an account? Let’s "
        let text2 = "Login"
        
        let goToLogin = NSMutableAttributedString(string: "\(text1)\(text2) ")
        goToLogin.addAttributes([
            .foregroundColor: UIColor(named: "Gray")!,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], range: NSString(string: goToLogin.string).range(of: text1))
        
        goToLogin.addAttributes([
            .foregroundColor: UIColor(named: "Primary")!,
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: NSString(string: goToLogin.string).range(of: text2))
        
        loginButton.setAttributedTitle(goToLogin, for: .normal)
    }
    
    @IBAction func eyePasswordButtonTapped(_ sender: Any) {
        let isSecureText = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureText
        passwordEyeButton.setImage(isSecureText ? UIImage(systemName: "eye.slash"): UIImage(systemName: "eye"), for: .normal)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        showLoginViewController()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        ApiService().signup(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { data, error in
            
            if let signupdata = data{
                
                let message = signupdata.message
                let status = signupdata.status
                
                switch status{
                case 200...299:
                    self.showOTPViewController()
                default:
                    let alert = UIAlertController(title: "SignUp Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            } else{
                let alertError = UIAlertController(title: "SignUp Error", message: "Error", preferredStyle: .alert)
                alertError.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertError, animated: true)
            }
            
            
        }
    }
}

extension SignUpViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case usernameTextField:
            usernameImage.tintColor = UIColor(named: "Primary")
            usernameSeparator.backgroundColor = UIColor(named: "Primary")
        case emailTextField:
            emailImage.tintColor = UIColor(named: "Primary")
            emailSeparator.backgroundColor = UIColor(named: "Primary")
        case passwordTextField:
            imagePassword.tintColor = UIColor(named: "Primary")
            passwordViewSeparator.backgroundColor = UIColor(named: "Primary")
        default: break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField{
        case usernameTextField:
            if !(textField.text ?? "").isEmpty{
                usernameImage.tintColor = UIColor(named: "Primary")
                usernameSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                usernameImage.tintColor = UIColor(named: "InitialGray")
                usernameSeparator.backgroundColor = UIColor(named: "InitialGray")
            }
        case emailTextField:
            if !(textField.text ?? "").isEmpty{
                emailImage.tintColor = UIColor(named: "Primary")
                emailSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                emailImage.tintColor = UIColor(named: "InitialGray")
                emailSeparator.backgroundColor = UIColor(named: "InitialGray")
            }
        case passwordTextField:
            if !(textField.text ?? "").isEmpty{
                imagePassword.tintColor = UIColor(named: "Primary")
                passwordViewSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                imagePassword.tintColor = UIColor(named: "InitialGray")
                passwordViewSeparator.backgroundColor = UIColor(named: "InitialGray")
            }
            
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        switch textField{
        case usernameTextField:
            let returnBool = validate(username: text, email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
            signUpButton.isEnabled = returnBool
        case emailTextField:
            let returnBool = validate(username: usernameTextField.text ?? "", email: text, password: passwordTextField.text ?? "")
            signUpButton.isEnabled = returnBool
            
        case passwordTextField:
            let returnBool = validate(username: usernameTextField.text ?? "", email: emailTextField.text ?? "" , password: text)
            signUpButton.isEnabled = returnBool
        default: break
        }
        return true
    }
}


extension SignUpViewController{
    func isUNameValid(uname: String) -> Bool {
        return uname.isUsername
        
    }
    
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
        
    }
    
    func isPasswordValid(password: String) -> Bool {
//        return password.isSecurePassword
        return password.count > 3
    }
    
    func validate(username:String, email: String, password: String) -> Bool{
        return isEmailValid(email: email) && isPasswordValid(password: password) && isUNameValid(uname: username)
    
    }
}

extension UIViewController{
    func showSignUpViewController(){
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"SIGNUP")
        navigationController?.setViewControllers([ViewController], animated: true)
        
    }
}

