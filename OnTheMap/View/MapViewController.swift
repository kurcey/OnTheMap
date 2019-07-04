//
//  ViewController.swift
//  OnTheMap
//
//  Created by user152630 on 6/11/19.
//  Copyright © 2019 user152630. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    
    let networkHelper = Network()
    let converter = Converter()
    let constants = Constants()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButtonPushed(_ sender: Any) {
        
        let userName = emailTextField.text
        let password = passwordTextField.text
        
        func fullResultFromLogin (_ result: AnyObject?,_ error: NSError?) {
            if (result != nil){
                //print(" logged in with \(String(describing: result!))")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "loggedInSegue", sender: nil)                }
            }
            else{
                DispatchQueue.main.async{
                    self.networkHelper.showAlertMsg(presentView: self, title: "Error logging in", message: "\(error!)"
                    )
                }
            }
        }
        
        if (userName == "" || password == ""){
            networkHelper.showAlertMsg(presentView: self, title: "Missing Fields", message: "Please fill in both username and password to continue ")
        }
        else {
            let passedParameters = [:] as [String : AnyObject]
            let loginMethod = constants.postAPISession
            
            let body = "{\"udacity\": {\"username\": \"\(String(describing: userName ?? ""))\", \"password\": \"\(password ?? "")\"}}"
            
            networkHelper.taskForPOSTMethod(loginMethod, parameters: passedParameters , jsonBody: body, completionHandlerForPOST: fullResultFromLogin)
        }
    }
    
    
    @objc func jumpToSignUpPage(){
        print("jumping")
        networkHelper.openUrl(urlString: "https://udacity.com")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signUp = UITapGestureRecognizer(target: self, action: #selector(jumpToSignUpPage))
        
        signupLabel.isUserInteractionEnabled = true
        signupLabel.addGestureRecognizer(signUp)
    }
    
    
}

