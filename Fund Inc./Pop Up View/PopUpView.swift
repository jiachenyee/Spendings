//
//  PopUpView.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 9/10/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import Foundation
import UIKit

var popFrame = CGRect()

class PopUpView: UIView {
    
    // MARK: Open Variables
    open var placeholder = ""
    open var animationDuration: TimeInterval = 0.3
    open var completion: (_ sender: PopUpView) -> Void = {_ in }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit(frame: nil)
    }
    
    private func commonInit(frame: CGRect?) {
        // Default to hidden
        isHidden = true
        
        // Shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.22
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
        
        // Corner Radius
        self.layer.cornerRadius = 20
        
        // Add XIB
        self.addSubview(screen)
                
        screen.frame = CGRect(x: 0, y: 0, width: screen.frame.width, height: screen.frame.height)
        
        screen.cancelOrContinueButton.setColors(buttonOne: #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1), buttonTwo: #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1))
        // Edit selection buttons
        screen.cancelOrContinueButton.addAction(actionOne: { (actionOne) in
            // Dismiss
            self.hide()
            
        }) { (actionTwo) in
            // Save and Dismiss
            // Saving data
            
            // Loading from the file
            var previousData = ExpenditureClass.loadFromFile() ?? []
            
            // Adding the new data into the file
            // Check if there is data first
            
            if self.screen.cashInput.text != nil && self.screen.cashInput.text != "" {
                previousData.append(ExpenditureClass(amount: Double(self.screen.cashInput.text!)!, isSpending: {
                    if self.screen.expenditureSelection.tag == 1{
                        return true
                    }
                    return false
                }(), store: self.screen.storeNameLabel.text ?? "", inputDate: Date()))
                
                // Writing back to file
                ExpenditureClass.saveToFile(expenditures: previousData)
            }
            
            self.hide()
        }
        
        screen.cancelOrContinueButton.titleOne = ""
        screen.cancelOrContinueButton.titleTwo = ""
        
        screen.cancelOrContinueButton.tintColor = .white
    }
    
    func hide() {
        // Kill keyboard
        self.endEditing(true)
        
        // Animate an exit
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
        }
        
        // Reset all values
        screen.cashInput.text = ""
        screen.expenditureSelection.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        screen.expenditureSelection.tintColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1)
        screen.expenditureSelection.tag = 0
        
        // Run Completion handler
        completion(self)
    }
    
    // when isHidden value gets changed
    override var isHidden: Bool {
        didSet {
            if isHidden {
            } else {
                // Animate in
                UIView.animate(withDuration: animationDuration/2, animations: {
                    self.alpha = 1
                    // Creating a POP effect with animation
                    self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    
                }) { (_) in
                    // Reset to normal after POP
                    UIView.animate(withDuration: self.animationDuration/2) {
                        self.transform = CGAffineTransform.identity
                    }
                }
            }
        }
    }
    
    // MARK: UI Elements
    // Getting from NIB
    // because I am a lazy person to programmetically do this
    lazy private var screen: PopUpViewUI = {
        let xib = Bundle.main.loadNibNamed("PopUpViewUI", owner: self, options: nil)
        let me = xib![0] as! PopUpViewUI
        
        return me
    }()
}
