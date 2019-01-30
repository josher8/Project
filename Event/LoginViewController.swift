//
//  LoginViewController.swift
//  Event
//
//  Created by Josh Slebodnik on 1/29/19.
//  Copyright © 2019 Josh Slebodnik. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Delegate to reload Home View Controller
    var delegate: reloadEvents?
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginView: UIView!
    @IBOutlet var loginLabel: UILabel!
    
    var loginGesture: UITapGestureRecognizer!
    var loading: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set up views
        loginView.layer.cornerRadius = 4
        loginGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.pressedLoginButton(_:)))
        loginView.addGestureRecognizer(loginGesture)
      
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == self.usernameField {
            passwordField.becomeFirstResponder()
        }
        
        if textField == self.passwordField{
            loginPressed()
        }
        
        return true
    }
    
    
    @objc func pressedLoginButton(_ tapGestureRecognizer:UITapGestureRecognizer){
        loginPressed()
    }
    
    func loginPressed() {
        
        //Removes Gesture so it doesn't get tapped more then once. Gets added back on completion
        loginView.removeGestureRecognizer(loginGesture)
        
        //If Username and password field don't have an characters, show an alert
        if ((usernameField.text?.count)! > 0) && ((passwordField.text?.count)! > 0){

            //Starts Alamofire login
            self.login(username: usernameField.text!, password: passwordField.text!) { token in
                if token != nil {
                    
                    //Saves Token in UserDefaults.
                    UserDefaults.standard.set(token?.token, forKey: "token")
                    //This will retry to login on HomeViewController
                    self.delegate?.retryList()
                    self.dismiss(animated: true, completion: nil)
                    
                }else {
                    
                    self.loginView.addGestureRecognizer(self.loginGesture)
                    
                }
            }
            
        }else {
            
            loginView.addGestureRecognizer(loginGesture)
            
            let alert = UIAlertController.init(title: "Error", message: "Please Enter a Valid Username and Password", preferredStyle: UIAlertController.Style.alert)
            let defaultAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: {action in })
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            
        }

        
    }
    
    func login(username:String, password: String, completion: @escaping (Token?) -> Void){
        
        Alamofire.request(LoginRouter.login(username,password)).responseString { response in
            guard response.result.isSuccess,
                let value = response.result.value else {
                    print("Error while getting token: \(String(describing: response.result.error))")
                    completion(nil)
                    return
            }
            completion(Token(json: value))
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
