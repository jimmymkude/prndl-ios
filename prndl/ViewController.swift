//
//  ViewController.swift
//  prndl
//
//  Created by Jimmy Mkude on 5/19/17.
//  Copyright © 2017 Jimmy Mkude. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -5.0, 5.0, -2.5, 2.5, -2.5, 2.5, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIViewController {
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
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

