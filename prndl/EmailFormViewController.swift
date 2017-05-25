//
//  EmailFormViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/20/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class EmailFormViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var passwd2TextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var passwd1 = ""
    var passwd2 = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        helloLabel.text = "Hey, \(firstName)"
    }
    
    func recieveNames(first: String, last: String){
        firstName = first
        lastName = last
        //update()
    }
    
    func valiateEmail() -> Bool {
        if email != ""{
            return true
        }
        return false
    }
    
    func validatePassword() -> Bool {
        if passwd1 == passwd2 && passwd1 != "" {
            return true
        }
        if passwd1 != passwd2 {
            helloLabel.text = "Sorry \(firstName), the passwords don't match."
        }
        else {
            helloLabel.text = "Sorry \(firstName), the password entry is not valid."
        }
        return false
    }
    
    @IBAction func onNextBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        email = emailTextField.text!
        passwd1 = passwdTextField.text!
        passwd2 = passwd2TextField.text!
    }

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        let emailValid = valiateEmail()
        let passwordValid = validatePassword()
        
        if !emailValid || !passwordValid {
            if !emailValid{
                emailTextField.placeholder = "Invalid e-mail address"
                emailTextField.shake()
            }
            if !passwordValid {
                passwdTextField.shake()
                passwd2TextField.shake()
            }
            return false
        }
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let newVC = segue.destination as? PhoneNumberViewController{
            let userinfo = UserInfo(first: firstName, last: lastName, email: email, passwd: passwd1)
            newVC.loadDataFromEmailFormViewController(userinfo: userinfo!)
        }
    }
 
    @IBAction func cancelToEmailFormViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToEmailFormViewController1(segue:UIStoryboardSegue) {
    }

}
