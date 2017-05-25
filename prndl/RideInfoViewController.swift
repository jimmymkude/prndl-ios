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
    
    @IBOutlet weak var colorPickerView: UIPickerView!
    
    @IBOutlet weak var makePickerView: UIPickerView!
    var userInfo : UserInfo?
    var color = ""
    var make = ""
    var model = ""
    
    let colors = ["Black", "Blue", "Brown", "Green", "Grey", "Gold", "Pink", "Purple", "Red", "Orange", "White", "Yellow"]
    
    let makes = ["Acura", "BMW", "Cadillac", "Chevrolet", "Chrysler", "GM", "Honda", "Hyundai", "Fiat", "Ford", "Ferrari", "Kia", "Lamborghini", "Lexus", "Mazeratti", "Mazda", "Mercedes Benz", "Mitsibushi", "Nissan", "Olds Mobile", "Subaru", "Toyota", "Volkswagen", "Zonda"]
    
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
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPickerView.delegate = self
        makePickerView.delegate = self


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

        self.model = modelTextField.text!
        
    }
    
    @IBAction func onSkipBtnClicked(_ sender: Any, forEvent event: UIEvent) {
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
