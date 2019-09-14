//
//  AddSelectionView.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 14/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSelectionButtons: UIView {

    /*
     Add a StackView containing the 2 buttons
     An open variable to set the arrays
     */
    
    // Editing the buttons through storyboard
    @IBInspectable open var titleOne: String = "" {
        didSet {
            // Updated titleOne
        }
    }
    
    @IBInspectable open var imageOne: UIImage = UIImage(systemName: "trash")! {
        didSet {
            // Updated titleOne
        }
    }
    
    @IBInspectable open var titleTwo: String = "" {
        didSet {
            // Updated titleTwo
        }
    }
    
    @IBInspectable open var imageTwo: UIImage = UIImage(systemName: "trash")! {
        didSet {
            // Updated titleOne
        }
    }
    
    // Editing the buttons through code
    open var buttonTitles: [String] = ["Button text", "Button text"] {
        didSet {
            // Update buttons as button titles has changed
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit(frame: nil)
    }
    
    private func commonInit(frame: CGRect?) {
        // Setup background
        self.backgroundColor = UIColor(red: 0.016, green: 0.165, blue: 0.169, alpha: 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.22
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
        self.layer.cornerRadius = 10
    }

}
