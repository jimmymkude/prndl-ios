//
//  SignUpViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/19/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var signedIn : Bool = false
    var userInfo : UserInfo?
    
    let menuItems = [
            "Reservations",
            "Vehicle Info",
            "Payment Info",
            "Upcoming Events",
            "Invite a Friend"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading sign up view controller")
        tableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update(){
        if signedIn{
            welcomeLabel.text = "Welcome \(userInfo!.firstName)"
            signUpBtn.isEnabled = false
            signUpBtn.isHidden = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    
    
    func loadUserInfo(userinfo: UserInfo){
        self.userInfo = userinfo
        signedIn = true
        update()
    }
    
    @IBAction func cancelToSignUpViewController1(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveToSignUpViewController1(segue:UIStoryboardSegue) {
        
        print("Saving to segue sign up view controller")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
