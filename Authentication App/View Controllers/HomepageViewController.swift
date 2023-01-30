//
//  EntryViewController.swift
//  Authentication App
//
//  Created by SBI Admin on 2020/05/24.
//  Copyright © 2020 SBI. All rights reserved.
//

import UIKit
import Firebase
import SwiftUI

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var labelEmailId: UILabel!
    @IBOutlet weak var viewMyExpenses: UIButton!
    @IBOutlet weak var signOut: UIButton!
    
    let constant = Constants()

    var textEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userEmail = Auth.auth().currentUser?.email
        self.labelEmailId.text = "Hello, \(userEmail ?? "")"
    }
    
    @IBAction func onTapViewExpenses() {
        print("on click")
        let hostingController = UIHostingController(rootView: ContentView())
        self.present(hostingController, animated: true, completion: nil)
    }
    
    @IBAction func onTapSignOut() {
        print("on signOut")
        do {
          try Auth.auth().signOut()
            let signinVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: constant.signinID) as! SignInViewController
//            self.show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
            self.present(signinVC, animated: true, completion: nil)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
