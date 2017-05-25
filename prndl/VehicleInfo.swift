//
//  VehicleInfo.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/24/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import Foundation

class VehicleInfo {
    var plateNo = ""
    var color = ""
    var make = ""
    var model = ""
    
    init(color: String = "", make: String = "", model: String = "", plateNo: String = ""){
        self.color = color
        self.make = make
        self.model = model
        self.plateNo = plateNo
    }
}
