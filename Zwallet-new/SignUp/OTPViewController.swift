//
//  OTPViewController.swift
//  Zwallet-new
//
//  Created by Randy Senjaya on 14/08/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    @IBOutlet weak var TextField1: UITextField!
    @IBOutlet weak var TextField2: UITextField!
    @IBOutlet weak var TextField3: UITextField!
    @IBOutlet weak var TextField4: UITextField!
    @IBOutlet weak var TextField5: UITextField!
    @IBOutlet weak var TextField6: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setup()
        TextField1.delegate = self
        TextField2.delegate = self
        TextField3.delegate = self
        TextField4.delegate = self
        TextField5.delegate = self
        TextField6.delegate = self
        
        confirmButton.isEnabled = false
    }
    
    func setup(){
        
        TextField1.layer.borderWidth = 2.0
        TextField1.layer.borderColor = UIColor(named: "InitialGray")?.cgColor
        TextField2.layer.borderWidth = 2.0
        TextField2.layer.borderColor = UIColor(named: "InitialGray")?.cgColor
        TextField3.layer.borderWidth = 2.0
        TextField3.layer.borderColor = UIColor(named: "InitialGray")?.cgColor
        TextField4.layer.borderWidth = 2.0
        TextField4.layer.borderColor = UIColor(named: "InitialGray")?.cgColor
        TextField5.layer.borderWidth = 2.0
        TextField5.layer.borderColor = UIColor(named: "InitialGray")?.cgColor
        TextField6.layer.borderWidth = 2.0
        TextField6.layer.borderColor = UIColor(named: "InitialGray")?.cgColor
        
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        showLoginViewController()
    }
    
}

extension OTPViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        
        if text.count == 1 {
            switch textField {
            case TextField1:
                TextField1.text = text
                TextField2.becomeFirstResponder()
            case TextField2:
                TextField2.text = text
                TextField3.becomeFirstResponder()
            case TextField3:
                TextField3.text = text
                TextField4.becomeFirstResponder()
            case TextField4:
                TextField4.text = text
                TextField5.becomeFirstResponder()
            case TextField5:
                TextField5.text = text
                TextField6.becomeFirstResponder()
            case TextField6:
                TextField6.text = text
                TextField6.resignFirstResponder()
            default: break
            }
            return false
        } else if text.count == 0  {
            
            return true
        } else {
            return false
        }
    }
    
    func validateOTP(){
        if (TextField1.text != "" && TextField2.text != "" && TextField3.text != "" && TextField3.text != "" && TextField5.text != "" && TextField6.text != "") {
            confirmButton.isEnabled = true
        } else {
            confirmButton.isEnabled = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validateOTP()
        
        switch textField{
        case TextField1:
            TextField1.layer.borderWidth = 2.0
            TextField1.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case TextField2:
            TextField2.layer.borderWidth = 2.0
            TextField2.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case TextField3:
            TextField3.layer.borderWidth = 2.0
            TextField3.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case TextField4:
            TextField4.layer.borderWidth = 2.0
            TextField4.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case TextField5:
            TextField5.layer.borderWidth = 2.0
            TextField5.layer.borderColor = UIColor(named: "Primary")?.cgColor
        case TextField6:
            TextField6.layer.borderWidth = 2.0
            TextField6.layer.borderColor = UIColor(named: "Primary")?.cgColor
        default: break
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        validateOTP()
    }
    
    
    
}

extension OTPViewController{
    
    }


extension UIViewController{
    func showOTPViewController(){
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let ViewController = storyboard.instantiateViewController(withIdentifier:"OTP")
        navigationController?.pushViewController(ViewController, animated: true)
        
    }
}

