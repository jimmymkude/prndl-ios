//
//  CardDetailsViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    var userInfo : UserInfo?
    var cardNumber : Int = -1
    var cvv : Int = -1
    var cvvNumDigits = -1
    var expirationDate = ""
    var zipCode : Int = -1
    var doneClicked = false
    
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    @IBOutlet weak var cvvTextField: UITextField!
    
    @IBOutlet weak var expirationTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromPaymentChoiceViewController(userinfo: UserInfo){
        self.userInfo = userinfo
    }
    
    func isNumeric(str: String) -> Bool{
        //let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        //var letterCount = 0
        //var digitCount = 0
        if str.characters.count == 0{
            return false
        }
        
        for uni in str.unicodeScalars {
            if !digits.contains(uni) {
                //letterCount += 1
                return false
            }
        }
        return true
    }

    @IBAction func onDoneBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        doneClicked = true
        if isNumeric(str: cardNumberTextField.text!) {
            cardNumber = Int(cardNumberTextField.text!)!
        }
        
        if isNumeric(str: cvvTextField.text!) {
            cvv = Int(cvvTextField.text!)!
            cvvNumDigits = cvvTextField.text!.characters.count
        }
        expirationDate = expirationTextField.text!
        
        if isNumeric(str: zipCodeTextField.text!){
            zipCode = Int(zipCodeTextField.text!)!
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if doneClicked {
            if cvv == -1 || cvvNumDigits != 3 || cardNumber == -1 || expirationDate == "" || zipCode == -1 {
                if cvv == -1 || cvvNumDigits != 3 {
                    cvvTextField.shake()
                }
                
                if cardNumber == -1 {
                    cardNumberTextField.shake()
                }
                
                if expirationDate == "" {
                    expirationTextField.shake()
                }
                
                if zipCode == -1 {
                    zipCodeTextField.shake()
                }
                
                return false
            }
        }
        
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let newVC = segue.destination as? SignUpViewController{
            newVC.loadUserInfo(userinfo: userInfo!)
        }
    }
 
    @IBAction func cancelToEmailFormViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToEmailFormViewController1(segue:UIStoryboardSegue) {
    }

}
