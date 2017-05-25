//
//  WhatsYourNameViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/20/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class WhatsYourNameViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    var firstName = ""
    var lastName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onNextClicked(_ sender: UIButton, forEvent event: UIEvent) {
        firstName = firstNameTextField.text!
        lastName = lastNameTextField.text!
    }

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        /*if let ident = identifier {
            if ident == "YourIdentifier" {
                if loginSuccess != true {
                    return false
                }
            }
        }*/
        if firstName == "" || lastName == "" {
            if firstName == ""{
                firstNameTextField.placeholder = "This is a required field"
                firstNameTextField.shake()
            }
            if lastName == "" {
                lastNameTextField.placeholder = "This is a required field"
                lastNameTextField.shake()
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
        if let newVC = segue.destination as? EmailFormViewController{
            newVC.recieveNames(first: firstName, last: lastName)
        }
    }
    
    
 
    
    @IBAction func cancelToWhatsYourNameViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToWhatsYourNameViewController1(segue:UIStoryboardSegue) {
    }

}
