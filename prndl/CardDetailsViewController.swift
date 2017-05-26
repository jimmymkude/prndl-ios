//
//  CardDetailsViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit
import Foundation



struct CustomDate {
    var month : Int = -1
    var year : Int = -1
    
    init(mon: Int, yr: Int) {
        month = mon
        year = yr
    }
    
    // makes sure date is after today
    func isValid() -> Bool {
        // now
        let now = Date(timeIntervalSinceNow: 0)
        let components = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: now)
        let currYear = components.year
        //let currMonth = components.month
        
        return month <= 12 && month >= 1 && year >= currYear!
    }
}

class CardDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var userInfo : UserInfo?
    //var cardNumber : Int = -1
    var cardNumber = ""
    var cvv : Int = -1
    var cvvNumDigits = -1
    var expirationDate = ""
    var zipCode : Int = -1
    var doneClicked = false
    var cardType : CardType?
    
    let cardToStr : [CardType : String] =
        [
            .amex : "American Express",
            .diners : "Diners",
            .discover : "Discover",
            .jcb : "Jcb",
            .masterCard : "MasterCard",
            .visa : "Visa"
            
        ]
    
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    @IBOutlet weak var cvvTextField: UITextField!
    
    @IBOutlet weak var expirationTextField: UITextField!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardNumberTextField.delegate = self
        expirationTextField.delegate = self
        cvvTextField.delegate = self
        zipCodeTextField.delegate = self

    }

    @IBAction func onCardNumberTextFieldChange(_ sender: Any) {
        print("Detecting Card Provider")
        // validate to get the cardType stored in the member variable cardType
        let _ = validateCardNumber()
        if cardType != nil {
            cardTypeLabel.text = cardToStr[cardType!]
        }else{
            cardTypeLabel.text = ""
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == expirationTextField{
            //Range.Length will greater than 0 if user is deleting text - Allow it to replace
            if range.length > 0
            {
                return true
            }
            
            //Dont allow empty strings
            if string == " "
            {
                return false
            }
            
            //Check for max length including the spacers we added
            if range.location >= 7
            {
                return false
            }
            
            var originalText = textField.text
            let replacementText = string.replacingOccurrences(of: " ", with: "")

            
            //Verify entered text is a numeric value
            let digits = NSCharacterSet.decimalDigits
            for char in replacementText.unicodeScalars
            {
                if !digits.contains(char)
                {
                    return false
                }
            }
            
            //Put / space after 2 digit0
            if range.location == 2
            {
                originalText?.append("/")
                textField.text = originalText
            }
        }
        
        else if textField == cardNumberTextField {
            //Range.Length will greater than 0 if user is deleting text - Allow it to replace
            if range.length > 0
            {
                return true
            }
            
            //Dont allow empty strings and check for max characters
            if string == " " || range.location >= 18 || !isNumeric(str: string)
            {
                return false
            }
            
        }
        
        else if textField == cvvTextField {
            if range.length > 0
            {
                return true
            }
            
            //Dont allow empty strings and check for max characters
            if string == " " || range.location >= 3 || !isNumeric(str: string)
            {
                return false
            }
        }
        
        else if textField == zipCodeTextField {
            if range.length > 0
            {
                return true
            }
            
            //Dont allow empty strings and check for max characters
            if string == " " || range.location >= 7 || !isNumeric(str: string)
            {
                return false
            }
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromPaymentChoiceViewController(userinfo: UserInfo){
        self.userInfo = userinfo
    }
    
    
    
    func validateCardNumber() -> Bool {
        switch CardState(fromPrefix: self.cardNumberTextField.text!) {
        case .identified(let card):
            print(card)
            cardType = card
            return card.isValid(self.cardNumberTextField.text!)
            
        case .indeterminate(let cards):
            print(cards)
            cardType = nil
            return false
            
        case .invalid:
            cardType = nil
            return false
        }
    }

    @IBAction func onDoneBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        doneClicked = true
        expirationDate = ""
        
        if isNumeric(str: cardNumberTextField.text!) {
            //cardNumber = Int(cardNumberTextField.text!)!
            cardNumber = cardNumberTextField.text!
        }
        
        if isNumeric(str: cvvTextField.text!) {
            cvv = Int(cvvTextField.text!)!
            cvvNumDigits = cvvTextField.text!.characters.count
        }
        
        
        let expStr = expirationTextField.text!
        if expStr.characters.count == 7 {
            let expArr = expStr.components(separatedBy: "/")
            let month = Int(expArr[0])
            let year = Int (expArr[1])
            let date = CustomDate(mon: month!, yr: year!)
            
            if date.isValid(){
                expirationDate = expirationTextField.text!
            }

        }
        
        if isNumeric(str: zipCodeTextField.text!){
            zipCode = Int(zipCodeTextField.text!)!
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if doneClicked {
            let cardNumberValid = validateCardNumber()
            if cvv == -1 || cvvNumDigits != 3 || !cardNumberValid || expirationDate == "" || zipCode == -1 {
                if cvv == -1 || cvvNumDigits != 3 {
                    cvvTextField.shake()
                }
                
                if !cardNumberValid {
                    cardNumberTextField.shake()
                }
                
                if expirationDate == "" {
                    expirationTextField.shake()
                }
                
                if zipCode == -1 {
                    zipCodeTextField.shake()
                }
                doneClicked = false
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
