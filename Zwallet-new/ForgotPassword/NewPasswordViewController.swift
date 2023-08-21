//
//  NewPasswordViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 15/08/23.
//

import UIKit


class NewPasswordViewController: UIViewController{
    
    @IBOutlet weak var newPassLockImage: UIImageView!
    @IBOutlet weak var newPassTextField: UITextField!
    @IBOutlet weak var newPassEyeButton: UIButton!
    @IBOutlet weak var newPassSeparator: UIView!
    
    @IBOutlet weak var confirmPassLockImage: UIImageView!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var confirmPassEyeButton: UIButton!
    @IBOutlet weak var confirmPassSeparator: UIView!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        newPassTextField.delegate = self
        confirmPassTextField.delegate = self
    }
    
    func setup(){
        newPassLockImage.tintColor = UIColor(named: "InitialGray")
        newPassSeparator.backgroundColor = UIColor(named: "InitialGray")
        confirmPassLockImage.tintColor = UIColor(named: "InitialGray")
        confirmPassSeparator.backgroundColor = UIColor(named: "InitialGray")
        
        resetButton.isEnabled = false
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        ApiService().forgotPassword(email: email, password: newPassTextField.text!) { data, error in
            
            if let resetData = data{
                
                let message = resetData.message
                let status = resetData.status
                
                switch status{
                case 200...299:
                    let alert = UIAlertController(title: "Reset Data Berhasil", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default){_ in self.showLoginViewController()})
                    self.present(alert, animated: true)
                    
                default:
                    let alert = UIAlertController(title: "Reset Data Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            } else{
                let alertError = UIAlertController(title: "SignUp Error", message: "Gagal", preferredStyle: .alert)
                alertError.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertError, animated: true)
            }

        }
    }
    
    @IBAction func newPassEyeButtonTapped(_ sender: Any) {
        openEye(newPassTextField, newPassEyeButton)
    }
    
    
    @IBAction func confirmPassEyeButtonTapped(_ sender: Any) {
        openEye(confirmPassTextField, confirmPassEyeButton)
    }
    
    
    
    func openEye(_ textField: UITextField,_ Button: UIButton ){
        
        let isSecureText = !textField.isSecureTextEntry
        textField.isSecureTextEntry = isSecureText
        Button.setImage(isSecureText ? UIImage(systemName: "eye.slash"): UIImage(systemName: "eye"), for: .normal)
        
    }
    
    func isPasswordValid(password: String) -> Bool {
//        return password.isSecurePassword
        return password.count > 3
    }
}

extension NewPasswordViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case newPassTextField:
            newPassLockImage.tintColor = UIColor(named: "Primary")
            newPassSeparator.backgroundColor = UIColor(named: "Primary")
        case confirmPassTextField:
            confirmPassLockImage.tintColor = UIColor(named: "Primary")
            confirmPassSeparator.backgroundColor = UIColor(named: "Primary")
        default: break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField{
        case newPassTextField:
            if !(textField.text ?? "").isEmpty{
                newPassLockImage.tintColor = UIColor(named: "Primary")
                newPassSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                newPassLockImage.tintColor = UIColor(named: "InitialGray")
                newPassSeparator.backgroundColor = UIColor(named: "InitialGray")
            }
        case confirmPassTextField:
            if !(textField.text ?? "").isEmpty{
                confirmPassLockImage.tintColor = UIColor(named: "Primary")
                confirmPassSeparator.backgroundColor = UIColor(named: "Primary")
            } else {
                confirmPassLockImage.tintColor = UIColor(named: "InitialGray")
                confirmPassSeparator.backgroundColor = UIColor(named: "InitialGray")
            }
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        if textField == newPassTextField {
            resetButton.isEnabled = confirmPassTextField.text ?? "" == text
        } else if textField == confirmPassTextField {
            resetButton.isEnabled = newPassTextField.text ?? "" == text
        }
        return true
        
    }
}

extension UIViewController{
    func showNewPassViewController(){
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"NEWPASS")
        navigationController?.setViewControllers([ViewController], animated: true)
        
    }
}
