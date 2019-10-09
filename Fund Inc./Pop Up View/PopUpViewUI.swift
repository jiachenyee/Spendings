//
//  PopUpViewUI.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 9/10/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewUI: UIView {
    @IBOutlet weak var expenditureSelection: UIButton!
    @IBOutlet weak var cashInput: UITextField!
    @IBOutlet weak var cancelOrContinueButton: CustomSelectionButtons!
    
    // Data Validation
    @IBAction func textChanged(_ sender: Any) {
        if cashInput.text != nil && !cashInput.text!.isEmpty {
            if cashInput.text!.last!.isNumber {
            } else {
                cashInput.text?.removeLast()
            }
        }
        
    }
    
}
