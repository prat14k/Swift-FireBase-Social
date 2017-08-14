//
//  ViewController.swift
//  Firebase Social Logins
//
//  Created by IIMJobs User on 13/08/17.
//  Copyright © 2017 14K. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController , FBSDKLoginButtonDelegate , GIDSignInUIDelegate{

    
    func setupFBButton(){
        let fbLoginBtn = FBSDKLoginButton()
        
        // fbLoginBtn.sizeToFit()
        
        view.addSubview(fbLoginBtn)
        
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXContr = NSLayoutConstraint(item: fbLoginBtn, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        
        let YContr = NSLayoutConstraint(item: fbLoginBtn, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: topLayoutGuide, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1.0, constant: 40.0)
        
        
        let widthContr = NSLayoutConstraint(item: fbLoginBtn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: -40.0)
        
        view.addConstraint(centerXContr)
        view.addConstraint(YContr)
        view.addConstraint(widthContr)
        
        fbLoginBtn.delegate = self
        fbLoginBtn.readPermissions = ["email", "public_profile" , "user_friends"]
        
        
    }
    
    
    func setupGoogleBtn(){
        let googleBtn = GIDSignInButton()
        view.addSubview(googleBtn)
        
        googleBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXContr = NSLayoutConstraint(item: googleBtn, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        
        let YContr = NSLayoutConstraint(item: googleBtn, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: topLayoutGuide, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1.0, constant: 80.0)
        
        
        let widthContr = NSLayoutConstraint(item: googleBtn, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: -40.0)
        
        view.addConstraint(centerXContr)
        view.addConstraint(YContr)
        view.addConstraint(widthContr)
        
        GIDSignIn.sharedInstance().uiDelegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupFBButton()
        setupGoogleBtn()
        
        
    }

    @IBAction func googleSigninAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    @IBAction func fbLoginAction(_ sender: UIButton) {
    
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile" , "user_friends"], from: self) { (result, error) in
            
            if error != nil {
                print("Login Error: ",error ?? "")
                return
            }
           // print(result?.token.tokenString)
            self.showEmailAddress()
        }
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
        
        showEmailAddress()
        
    }
    
    func showEmailAddress(){
        //print("Successful login to fb")
        
        let accessToken = FBSDKAccessToken.current()
        
        let accessTokenString = accessToken?.tokenString
        
        if(accessTokenString == nil){
            return;
        }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString!)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil {
                print("Firebase Error: ",error ?? "")
            }
            
            print(user ?? "")
        }
        
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,email,first_name,last_name,link,locale, name, picture.type(large), birthday,location ,friends ,hometown , friendlists"]).start { (connection, result, error) in
            if error != nil {
                print("Graph Request Error : ",error ?? "")
                return
            }
            
            print(result ?? "")
            
        }

    }
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        print("Did Logout of FB")
    }
    
    

    

}

