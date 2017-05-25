//
//  PhoneNumberViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController, UITextFieldDelegate {
    var userInfo : UserInfo?
    var phoneNum : String = ""
    var nextClicked = false
    var decimalString : NSString = ""
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromEmailFormViewController(userinfo: UserInfo){
        self.userInfo = userinfo
    }
    
    func validatePhoneNumber() -> Bool{
        if phoneNum.characters.count == 10{
            return true
        }
        
        phoneNumberTextField.shake()
        return false
    }
    
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print("Auto correcting")
        if textField == phoneNumberTextField
        {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            //let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted as CharacterSet)

            self.decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne
            {
                formattedString.append("+1 ")
                index += 1
            }
            if (length - index) > 3
            {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", areaCode)
                index += 3
            }
            if length - index > 3
            {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            print(decimalString)
            return false
        }
        else
        {
            return true
        }
    }
    
    
    @IBAction func onNextBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        phoneNum = decimalString as String
        userInfo?.phoneNo = phoneNum
        nextClicked = true
    }
    
    @IBAction func onSkipBtnClicked(_ sender: Any, forEvent event: UIEvent) {
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if !nextClicked || validatePhoneNumber() {
            return true
        }
        
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let newVC = segue.destination as? RideInfoViewController{
            newVC.loadDataFromPhoneNumberViewController(userinfo: userInfo!)
        }
        
    }
 
    @IBAction func cancelToPhoneNumberViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToPhoneNumberViewController1(segue:UIStoryboardSegue) {
    }

}
