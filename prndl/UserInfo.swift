//
//  UserInfo.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import Foundation

class UserInfo {
    var firstName = ""
    var lastName = ""
    var email = ""
    var passwd = ""
    var phoneNo = ""
    var vehicleInfo : VehicleInfo?
    var paymentChoice = ""
    
    init?(first: String = "", last: String = "", email: String = "", passwd: String = "", phoneNo: String = "") {
        self.firstName = first
        self.lastName = last
        self.email = email
        self.passwd = passwd
        self.phoneNo = phoneNo
    }
}
