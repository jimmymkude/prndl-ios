//
//  PlateNumberViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class PlateNumberViewController: UIViewController, UITextFieldDelegate {
    var userInfo : UserInfo?
    var plateNumber = ""
    var nextClicked = false
    
    @IBOutlet weak var plateNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plateNumberTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSkipBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        nextClicked = false
    }
    
    @IBAction func onNextBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        plateNumber = plateNumberTextField.text!
        nextClicked = true
    }
    
    func loadDataFromRideInfoViewController(userinfo: UserInfo){
        self.userInfo = userinfo
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        //Check for max length including the spacers we added
        if range.location >= 7
        {
            return false
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident != "next" {
                return true
            }
            if !nextClicked || plateNumber.characters.count >= 6 {
                return true
            }
            plateNumberTextField.shake()
            return false
        }
        
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let newVC = segue.destination as? PaymentChoiceViewController{
            newVC.loadDataFromPlateNumberViewController(userinfo: self.userInfo!)
        }
    }
    
    
    @IBAction func cancelToPlateNumberViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToPlateNumberViewController1(segue:UIStoryboardSegue) {
    }

}
