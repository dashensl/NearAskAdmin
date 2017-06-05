//
//  ViewController.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 5/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("hahahahhahahahhahahahahaahahhahahahhahahah qpfjqoigh oeiq hgiuq")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(_ sender: Any) {
        if (validateUserLogin()) {
            self.renderAlert(title: "sweet", message: "login successfully !!")
        } else {
            self.renderAlert(title: "fuck", message: "login failed !!")
        }
    }
    
    func validateUserLogin() -> Bool{
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            //If your plist contain root as Array
            if let dic = NSDictionary(contentsOfFile: path){
                if case let userlist as Array<NSDictionary> = dic["UserList"] {
                    let userinfo: [String:String] = ["username": (usernameTF.text)!, "password":  (passwordTF.text)!]
                    if (userlist.contains(userinfo as NSDictionary)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    func renderAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

