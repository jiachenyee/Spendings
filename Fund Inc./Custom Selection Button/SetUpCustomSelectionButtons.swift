//
//  SetUpCustomSelectionButtons.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 17/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import Foundation
import UIKit

extension CustomSelectionButtons {
    
    public func setUpSelf() {
        // Setup background
        self.backgroundColor = .white
        
        // Shadows
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.22
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
        
        // Corner Radius
        self.layer.cornerRadius = 10
        
        self.addSubview(screen)
    }
    
    public func setUpTapGestureRecognisers() {
        // Setting the actions on the tap gesture recogniser
        tapGestureRecogniserOne.addTarget(self, action: #selector(actionOneClicked))
        tapGestureRecogniserTwo.addTarget(self, action: #selector(actionTwoClicked))
        
        screen.buttonOne.addGestureRecognizer(tapGestureRecogniserOne)
        screen.buttonTwo.addGestureRecognizer(tapGestureRecogniserTwo)
    }
    
    @objc private func actionOneClicked() {
        actionOne(self)
    }
    
    @objc private func actionTwoClicked() {
        actionTwo(self)
    }
}
