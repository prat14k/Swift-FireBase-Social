//
//  ViewController.swift
//  Firebase Social Logins
//
//  Created by IIMJobs User on 13/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let fbLoginBtn = FBSDKLoginButton()
        
       // fbLoginBtn.sizeToFit()
        
        view.addSubview(fbLoginBtn)
        
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXContr = NSLayoutConstraint(item: fbLoginBtn, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
    
        let YContr = NSLayoutConstraint(item: fbLoginBtn, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.topMargin, multiplier: 1.0, constant: 40.0)
        
        
        let widthContr = NSLayoutConstraint(item: fbLoginBtn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: -40.0)
        
        view.addConstraint(centerXContr)
        view.addConstraint(YContr)
        view.addConstraint(widthContr)
        
        fbLoginBtn.delegate = self
        
        
    }

    /**
     Sent to the delegate when the button was used to login.
     - Parameter loginButton: the sender
     - Parameter result: The results of the login
     - Parameter error: The error (if any) from the login
     */
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        
        if error != nil {
            print(error)
            return
        }
        
        print("Successful login to fb")
    }
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("Did Logout of FB")
    }
    
    

    

}

