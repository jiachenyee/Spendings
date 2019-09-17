//
//  CustomSelectionButtonsView.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 14/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit

class CustomSelectionButtonsView: UIView {
    
    @IBOutlet weak open var buttonOne: UIView!
    @IBOutlet weak open var buttonTwo: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit(frame: nil)
    }
    
    private func commonInit(frame: CGRect?) {
        
    }
}
