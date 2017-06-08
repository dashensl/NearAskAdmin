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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font == \(familyName) \(names)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            print("shouldPerformSegue loginSegue")
            return validateUserLogin();
        }
        return true;
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
        self.renderAlert(title: "oops!", message: "login failed")
        return false
    }
    func renderAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

