//
//  LogInViewController.swift
//  RickM+
//
//  Created by RickSun on 2020/2/7.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit
import Firebase


class LogInViewController: UIViewController {
    
    
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var accountTtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func signUpBtn(_ sender: UIButton) {
        if accountTtextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: accountTtextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    print("You have successfully signed up")
                    let alertController = UIAlertController(title: "親愛的用戶您好", message: "註冊成功", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    if let userUid = Auth.auth().currentUser?.uid {
                        UserInfo.share.logInUserUid = userUid
                        self.addUserData()
                    }
                    
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    @IBAction func signInBtn(_ sender: UIButton) {
        if self.accountTtextField.text == "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "錯誤", message: "請輸入帳號與密碼", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().signIn(withEmail: accountTtextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    //                    self.performSegue(withIdentifier: "SignIn", sender: nil)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")
                    
                    vc?.modalPresentationStyle = .fullScreen
                    
                    self.present(vc!, animated: true, completion: nil)
                    if let userUid = Auth.auth().currentUser?.uid {
                        UserInfo.share.logInUserUid = userUid
                    }
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
        //        performSegue(withIdentifier: "SignIn", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func addUserData() {
        let db = Firestore.firestore()
        db.collection("Users").document("\(UserInfo.share.logInUserUid)").setData([
            "email": "\(accountTtextField.text!)",
            "friends": ["rick0120@hotmail.com"],
            "id": "\(UserInfo.share.logInUserUid)",
            "mID": "default",
            "name": "default",
            "phoneNumber": "+886********",
            "status": "default",
            "colleague": false,
            ])
        { (error) in
            if let error = error {
                print(error)
            }

        }

    }
 
}
