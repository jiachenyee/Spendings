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
    @IBOutlet weak var storeNameLabel: UITextField!
    
    // Data Validation
    @IBAction func textChanged(_ sender: Any) {
        if cashInput.text != nil && !cashInput.text!.isEmpty {
            if cashInput.text!.last!.isNumber || cashInput.text!.last! == "." {
            } else {
                cashInput.text?.removeLast()
            }
        }
    }
    
    @IBAction func changedSpendings(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
            sender.tag = 1
        } else {
            sender.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1)
            sender.tag = 0
        }
    }
}
