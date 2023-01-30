//
//  SignUpViewController.swift
//  Authentication App
//
//  Created by SBI Admin on 2020/05/24.
//  Copyright © 2020 SBI. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignUpViewController: UIViewController {

    @IBOutlet weak var fbSignupButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!

    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    let imageChecked = UIImage(named: "checked") as UIImage?
    let imageNotChecked = UIImage(named: "not checked") as UIImage?
    
    var isRemeberMeCheck = false
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        
        fullName.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        username.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        password.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        confirmPassword.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
    }
    
    @IBAction func setUpGoogle(_sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
                // Create Google Sign In configuration object.
                let config = GIDConfiguration(clientID: clientID)
                
                // Start the sign in flow!
                GIDSignIn.sharedInstance.signIn(with: config, presenting: (UIApplication.shared.windows.first?.rootViewController)!) { user, error in

                  if let error = error {
                    print(error.localizedDescription)
                    return
                  }

                  guard
                    let authentication = user?.authentication,
                    let idToken = authentication.idToken
                  else {
                    return
                  }

                    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                    accessToken: authentication.accessToken)

                    // Authenticate with Firebase using the credential object
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            print("authentication error \(error.localizedDescription)")
                            return
                        }
                        print(authResult ?? "none")
                    }
                }
    }

    @IBAction func createAccount(_ sender: Any) {
        
        
        if fullName.backgroundColor == .red {
            fullName.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        }
        
        if username.backgroundColor == .red {
            username.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        }
        
        if password.backgroundColor == .red {
            password.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        }
        
        if confirmPassword.backgroundColor == .red {
            confirmPassword.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        }
        
        guard fullName.text != "" else {
            
            print("Name text field should not be empty")
            fullName.backgroundColor = .red
            fullName.placeholder = "Full name | required"
            return
        }
        
        guard username.text != "" else {
            
            print("Email text field should not be empty")
            username.backgroundColor = .red
            username.placeholder = "Email | required"
            return
        }
        
        
        guard password.text != "" else {
            
            print("Password text field should not be empty")
            password.backgroundColor = .red
            password.placeholder = "Password | required"
            return
        }
        
        guard confirmPassword.text != "" else {
            
            print("Confirm password text field should not be empty")
            confirmPassword.backgroundColor = .red
            confirmPassword.placeholder = "Confirm password | required"
            return
        }
        
        guard password.text == confirmPassword.text else {
            print("passwords don't match")
            confirmPassword.backgroundColor = .red
            confirmPassword.text = ""
            confirmPassword.placeholder = "Passwords do not match"
            return
        }
        
        //loadingV(is_loading: true)
        
        let name = fullName.text!
        let user = username.text!
        let pass = password.text!
        
        let reqbody = ["full_name":name,"username":user,"password":pass]
//        register(reqbody: reqbody)
        Auth.auth().createUser(withEmail: user, password: pass) { authResult, error in
          // ...
            if let _eror = error {
                //something bad happning
                print(_eror.localizedDescription )
            }
            else{
               //user registered successfully
               print(authResult)
             let homePageCtr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homepage") as! HomepageViewController
                
                homePageCtr.textEmail = "\(authResult?.user.email))"
                self.present(homePageCtr, animated: true, completion: nil)
           }
            
        }
    }
    
    @IBAction func checkPressed(_ sender: Any) { checkRememberMe() }
}

// UI Config
extension SignUpViewController {
    
       func configureUI(){
           setImage()
           setupButtons()
       }
       
       func setImage(){
           
           rememberMeButton.setImage(imageNotChecked, for: .normal)
           rememberMeButton.contentVerticalAlignment = .fill
           rememberMeButton.contentHorizontalAlignment = .fill
       }
       
       func setupButtons(){
           
           signupButton.layer.cornerRadius = signupButton.frame.height
            / 2
//
//           fbSignupButton.layer.cornerRadius = fbSignupButton.frame.height
//           / 2
       }
}

extension SignUpViewController {
    
    func checkRememberMe(){
        
        print("in check")
        if isRemeberMeCheck == false {
            
            rememberMeButton.setImage(imageChecked, for: .normal)
            print("on")
            isRemeberMeCheck = true
        } else {
            rememberMeButton.setImage(imageNotChecked, for: .normal)
            print("off")
            isRemeberMeCheck = false
        }
    }
}

// signup api call
extension SignUpViewController {
    
   func register(reqbody:[String:String]){
        
//        AuthappNetworkService.register(reqbody, resultCallback: {
//        res in
//
//        print("OOra")
//        print(res! as Any)
//        if let status:Dictionary<String,AnyObject> = res!{
//            print(status)
//            print("here")
//            print(status["isSuccessful"]!)
//            //LMLoading.hide()
//            switch status["isSuccessful"] as! Int {
//                case 1:
//                    print("natha oora")
//
//                    //self.loadingV(is_loading: false)
//                    // Open app home page
//                self.present(openViewController(_storyboard:"Main",idName: "otpPage", vc: OTPViewController()), animated: true, completion: nil)
//
//                case 0:
//                    print("Nope")
//                    //self.loadingV(is_loading: false)
//                showMessageDialog("Error", message: "Email or Password incorrect", image: nil, axis: .horizontal, viewController: self, handler: {
//
//                    // Clear password text field
//                    //self.passwordTextField.text = ""
//
//                })
//
//                default:
//                    print()
//                }
//            }
//
//        }, errorCallback: { (err) in
//            if (err.containsIgnoringCase(find: "serialize") || err.containsIgnoringCase(find: "JSON")){
//                DispatchQueue.main.async {
//                    //self.loadingV(is_loading: false)
//                    //self.delegate?.peachPay(self, didFailPaymentWithResult: ["error" : err as AnyObject])
//                }
//            }else{
//                //self.loadingV(is_loading: false)
//                showMessageDialog("Error", message: err, image: nil, axis: .horizontal, viewController: self, handler: {
//
//                })
//            }
//            print(err)
//        })
    }
}
