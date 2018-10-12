//
//  SignupViewController.swift
//  PaletteStudio
//
//  Created by daihase on 2016/10/28.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    var presenter: SignupModuleInterface!
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupButtonMask: UIView!
    
    var mailTextFieldPlaceholder = "Email address"
    var passwordTextFieldPlaceholder = "Password"
    var loginButtonText = "Sign up"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        self.setNavigationBar()
        self.setLeftButton()
        self.setTextField()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver( self,
                                                selector: #selector(textFieldDidChanged),
                                                name: NSNotification.Name.UITextFieldTextDidChange,
                                                object: nil
        )
    }

    func configure() {
        self.signupButton.setTitle(self.loginButtonText.localized(), for: .normal)
        self.signupButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.companyColor()), for: .normal)
        self.signupButton.setBackgroundImage(PSUtil.createColorImageFromUIColor(color: PSColor.buttonHighlightCompanyColor()), for: .highlighted)
    }
    
    func setNavigationBar() {
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    func setLeftButton() {
        let backButtonImage = UIImage(named:"NavigationCloseBlackButton")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(tapCloseButton))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setTextField() {
        self.mailTextField.delegate = self
        self.mailTextField.placeholder = self.mailTextFieldPlaceholder
        self.mailTextField.keyboardType = UIKeyboardType.emailAddress
        self.mailTextField.returnKeyType = .done
        self.mailTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        
        self.passwordTextField.delegate = self
        self.passwordTextField.placeholder = self.passwordTextFieldPlaceholder
        self.passwordTextField.keyboardType = UIKeyboardType.default
        self.passwordTextField.returnKeyType = .done
        self.passwordTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        self.passwordTextField.isSecureTextEntry = true
    }
    
    func tapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSignupButton(_ sender: Any) {
        if Validation.validEmail(self.mailTextField.text!) {
            if Validation.validPassword(self.passwordTextField.text!).characters.count >= 6 {
                let parameters = [ "session": [
                    "email": self.mailTextField.text!,
                    "password": self.passwordTextField.text!]]
                self.presenter.executeSignupApi(parameters)
            } else {
                PSUtil.showAlertView(message: "正しいパスワードを入力してください。".localized(), actionTitles: ["OK"], actions: [{()->() in}])
                
            }
        } else {
            PSUtil.showAlertView(message: "正しいメールアドレスを入力してください。".localized(), actionTitles: ["OK"], actions: [{()->() in}])
        }
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func checkButtonMaskState() {
        if self.mailTextField.text!.characters.count > 0 && self.passwordTextField.text!.characters.count > 0 {
            self.signupButtonMask.isHidden = true
        } else {
            self.signupButtonMask.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SignupViewController: SignupViewInterface {
    func dismissSignupViewController() {
        if self.mailTextField.isFirstResponder {
            self.mailTextField.resignFirstResponder()
        }
        if self.passwordTextField.isFirstResponder {
            self.passwordTextField.resignFirstResponder()
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidChanged() {
        self.checkButtonMaskState()
    }
}

