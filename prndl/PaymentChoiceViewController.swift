//
//  PaymentChoiceViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class PaymentChoiceViewController: UIViewController {
    var userInfo : UserInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCardSelected(_ sender: Any, forEvent event: UIEvent) {
        userInfo?.paymentChoice = "card"
    }
    
    
    @IBAction func onVenmoSelected(_ sender: Any, forEvent event: UIEvent) {
        userInfo?.paymentChoice = "venmo"
    }
    
    @IBAction func onLaterSelected(_ sender: Any, forEvent event: UIEvent) {
        
    }
    
    func loadDataFromPlateNumberViewController(userinfo: UserInfo){
        self.userInfo = userinfo
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let newVC = segue.destination as? CardDetailsViewController{
            newVC.loadDataFromPaymentChoiceViewController(userinfo: userInfo!)
        }
        
        if let newVC = segue.destination as? SignUpViewController{
            newVC.loadUserInfo(userinfo: userInfo!)
        }
        
    }
 
    
    @IBAction func cancelToPaymentChoiceViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToPaymentChoiceViewController1(segue:UIStoryboardSegue) {
    }

}
