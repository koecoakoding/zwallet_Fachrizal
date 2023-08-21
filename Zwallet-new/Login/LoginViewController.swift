//
//  ViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 14/08/23.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageEmail: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailViewSeparator: UIView!
    
    @IBOutlet weak var imagePassword: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordViewSeparator: UIView!
    @IBOutlet weak var passwordEyeButton: UIButton!
    
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var wrongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        separatorTextButton()
        wrongLabel.isHidden = true
    }
    
    func setup(){
        imageEmail.tintColor = UIColor(named: "InitialGray")
        emailViewSeparator.backgroundColor = UIColor(named: "InitialGray")
        
        passwordEyeButton.tintColor = UIColor(named: "InitialGray")
        imagePassword.tintColor = UIColor(named: "InitialGray")
        passwordViewSeparator.backgroundColor = UIColor(named: "InitialGray")
        
        loginButton.isEnabled = false
        
        setupKeyboardHiding()

    }
    
    private func setupKeyboardHiding() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    func separatorTextButton(){
        
        let text1 = "Don’t have an account? Let’s "
        let text2 = "Sign Up"
        
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
        
        signUpButton.setAttributedTitle(goToLogin, for: .normal)
    }
                                                        
    @IBAction func forgotButtonTapped(_ sender: Any) {
        
        showResetViewController()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        ApiService().login(email: emailTextField.text!, password: passwordTextField.text!) { data, error in
            
            if let loginData = data{
                UserDefaults.standard.set(loginData.token, forKey: Constant.kAccessTokenKey)
                let storyboard = UIStoryboard(name: "Profile", bundle: nil)
                let ViewController = storyboard.instantiateViewController(withIdentifier:"TABBAR")
                
                
//                let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                let window = scenes?.windows.last
//                window?.rootViewController = ViewController
                
                self.navigationController?.pushViewController(ViewController, animated: true)
            } else {
                self.imageEmail.tintColor = .red
                self.emailViewSeparator.backgroundColor = .red
                self.imagePassword.tintColor = .red
                self.passwordViewSeparator.backgroundColor = .red
                self.emailTextField.text = ""
                self.passwordTextField.text = ""

                self.wrongLabel.isHidden = false
                self.loginButton.isEnabled = false
            }
        }
    }
    
    @IBAction func eyeButtonTapped(_ sender: Any) {
        let isSecureText = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry = isSecureText
        passwordEyeButton.setImage(isSecureText ? UIImage(systemName: "eye.slash"): UIImage(systemName: "eye"), for: .normal)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        showSignUpViewController()
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case emailTextField:
            imageEmail.tintColor = UIColor(named: "Primary")
            emailViewSeparator.backgroundColor = UIColor(named: "Primary")
        case passwordTextField:
            imagePassword.tintColor = UIColor(named: "Primary")
            passwordViewSeparator.backgroundColor = UIColor(named: "Primary")
        default: break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField{
        case emailTextField:
            if !(textField.text ?? "").isEmpty{
                imageEmail.tintColor = UIColor(named: "Primary")
                emailViewSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                imageEmail.tintColor = UIColor(named: "InitialGray")
                emailViewSeparator.backgroundColor = UIColor(named: "InitialGray")
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
        case emailTextField:
            let returnBool = validate(email: text, password: passwordTextField.text ?? "")
            loginButton.isEnabled = returnBool
            
        case passwordTextField:
            let returnBool = validate(email: emailTextField.text ?? "" , password: text)
            loginButton.isEnabled = returnBool
        default: break
        }
        return true
    }
}

extension LoginViewController{
    func isEmailValid(email: String) -> Bool {
        return email.isEmail
        
    }
    
    func isPasswordValid(password: String) -> Bool {
//        return password.isSecurePassword
        return password.count > 3
    }
    
    func validate(email: String, password: String) -> Bool{
        return isEmailValid(email: email) && isPasswordValid(password: password)
    
    }
}


extension UIViewController{
    func showLoginViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"LOGIN")
        
//        let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        let window = scenes?.windows.last
//        window?.rootViewController = ViewController
        
        navigationController?.setViewControllers([ViewController], animated: true)
        
    }
}

