//
//  RideInfoViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class RideInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var modelTextField: UITextField!
    
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    @IBOutlet weak var makePickerView: UIPickerView!
    
    var userInfo : UserInfo?
    var color = ""
    var make = ""
    var model = ""
    var nextClicked = false
    
    let colors = ["Select", "Black", "Blue", "Brown", "Green", "Grey", "Gold", "Pink", "Purple", "Red", "Orange", "White", "Yellow"]
    
    let makes = ["Select", "Acura", "BMW", "Cadillac", "Chevrolet", "Chrysler", "GM", "Honda", "Hyundai", "Fiat", "Ford", "Ferrari", "Kia", "Lamborghini", "Lexus", "Mazeratti", "Mazda", "Mercedes Benz", "Mitsibushi", "Nissan", "Olds Mobile", "Subaru", "Toyota", "Volkswagen", "Zonda"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var string = ""
        if pickerView == colorPickerView {
            string = colors[row]
        }
        
        if pickerView == makePickerView {
            string = makes[row]
        }
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == colorPickerView {
            count = colors.count
        }
        
        if pickerView == makePickerView {
            count = makes.count
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorPickerView {
            color = colors[row]
        }
        
        if pickerView == makePickerView {
            make = makes[row]
            modelLabel.text = "What Model is your \(make)?"
            
            if make == "Select" {
                modelLabel.text = "What Model is your vehicle?"
                modelLabel.isHidden = true
                modelTextField.isHidden = true
            }
            else{
                modelLabel.isHidden = false
                modelTextField.isHidden = false
            }
            
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.delegate = self
        makePickerView.delegate = self
        
        color = colors[0]
        make = makes[0]
        
        modelLabel.isHidden = true
        modelTextField.isHidden = true


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromPhoneNumberViewController(userinfo: UserInfo){
        self.userInfo = userinfo
    }

    @IBAction func onNextBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        self.nextClicked = true
        self.model = modelTextField.text!
        
    }
    
    @IBAction func onSkipBtnClicked(_ sender: Any, forEvent event: UIEvent) {
        self.nextClicked = false
    }
    
    func validateInput() -> Bool{
        if color == "Select" || make == "Select" || model == "Select" {
            if color == "Select" {
                colorPickerView.shake()
            }
            
            if make == "Select" {
                makePickerView.shake()
            }
            
            if model == "Select" {
                modelTextField.shake()
            }
            return false
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident != "next" {
                return true
            }
            if !nextClicked || validateInput() {
                return true
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
        if let newVC = segue.destination as? PlateNumberViewController{
            newVC.loadDataFromRideInfoViewController(userinfo: userInfo!)
        }
    }
 
    
    @IBAction func cancelToRideInfoViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToRideInfoViewController1(segue:UIStoryboardSegue) {
    }

}
