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
    var placeholder = ""
    var animationDuration: TimeInterval = 0.3
    
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
        
        print(UIScreen.main.bounds.width)
        
        screen.frame = CGRect(x: 0, y: 0, width: screen.frame.width, height: screen.frame.height)
        
        screen.cancelOrContinueButton.setColors(buttonOne: #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1), buttonTwo: #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1))
        // Edit selection buttons
        screen.cancelOrContinueButton.addAction(actionOne: { (actionOne) in
            // Save and Dismiss
            self.hide()
        }) { (actionTwo) in
            // Dismiss
            self.hide()
        }
        
        screen.cancelOrContinueButton.titleOne = ""
        screen.cancelOrContinueButton.titleTwo = ""
        
        screen.cancelOrContinueButton.tintColor = .white
    }
    
    func hide() {
        // Animate an exit
        // Reset all values
        UIView.animate(withDuration: animationDuration, animations: {
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
        }
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
