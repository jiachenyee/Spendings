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
    
    // Declaring the actions when one and two are edited and what not
    // Block accepts a sender, which would be self
    @objc var actionOne: (_ sender: CustomSelectionButtons) -> Void = {_ in } {
        didSet {
            setUpTapGestureRecognisers()
        }
    }
    
    @objc var actionTwo: (_ sender: CustomSelectionButtons) -> Void = {_ in } {
        didSet {
            setUpTapGestureRecognisers()
        }
    }
    
    // Editing the buttons through storyboard
    // Interface Builder variables
    @IBInspectable open var titleOne: String = "" {
        didSet {
            // Updated titleOne
            // Update the buttonInfo thing so I don't need to deal with so much nonsense
            buttonInfo[0].title = titleOne
        }
    }
    
    @IBInspectable open var imageOne: UIImage = UIImage(systemName: "trash")! {
        didSet {
            // Updated titleOne
            // Update the buttonInfo thing so I don't need to deal with so much nonsense
            buttonInfo[0].image = imageOne
        }
    }
    
    @IBInspectable open var titleTwo: String = "" {
        didSet {
            // Updated titleTwo
            // Update the buttonInfo thing so I don't need to deal with so much nonsense
            buttonInfo[1].title = titleTwo
        }
    }
    
    @IBInspectable open var imageTwo: UIImage = UIImage(systemName: "trash")! {
        didSet {
            // Updated titleOne
            // Update the buttonInfo thing so I don't need to deal with so much nonsense
            buttonInfo[1].image = imageTwo
        }
    }
    
    // Tap Gesture Recognisers
    var tapGestureRecogniserOne: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapGestureRecogniserTwo: UITapGestureRecognizer = UITapGestureRecognizer()
    
    // Getting from NIB
    // because I am a lazy person to programmetically do this
    lazy var screen: CustomSelectionButtonsView = {
        let xib = Bundle.main.loadNibNamed("CustomSelectionButtons", owner: self, options: nil)
        let me = xib![0] as! CustomSelectionButtonsView
        
        return me
    }()
    
    // Editing the buttons through code
    // buttonInfo is an array of a tuple of image and button
    // Updating via Storyboards will call this function because I was too lazy to do it any other way
    open var buttonInfo: [(image: UIImage, title: String)] = [(UIImage(), "Button 1"), (UIImage(), "Button 2")] {
        didSet {
            // Check if the buttonInfo variable is more than or less than two and provide the handy error message
            // This is safeguard against myself and my stupidity when working on this code
            
            if buttonInfo.count != 2 {
                fatalError(buttonInfo.count > 2 ? "Custom Selection Button has too many items" : "Custom Selection Button has too few items")
            }
            
            // Update buttons
            // Declaring Button 1 and 2 items
            let buttonOneStack = screen.buttonOne.subviews.first as! UIStackView
            let buttonOneImageView = buttonOneStack.subviews[0] as! UIImageView
            let buttonOneLabel = buttonOneStack.subviews[1] as! UILabel
            
            let buttonTwoStack = screen.buttonTwo.subviews.first as! UIStackView
            let buttonTwoImageView = buttonTwoStack.subviews[0] as! UIImageView
            let buttonTwoLabel = buttonTwoStack.subviews[1] as! UILabel
            
            // Updating button 1 and 2
            // Adding in the images
            buttonOneImageView.image = buttonInfo[0].image
            buttonTwoImageView.image = buttonInfo[1].image
            
            buttonOneImageView.tintColor = self.tintColor
            buttonTwoImageView.tintColor = self.tintColor
            
            // Adding in the titles
            buttonOneLabel.text = buttonInfo[0].title
            buttonTwoLabel.text = buttonInfo[1].title
        }
    }
    
    // The easy way to update it without memorising syntax and what not and just by pressing enter
    open func addAction(actionOne: @escaping (_ sender: CustomSelectionButtons) -> Void, actionTwo: @escaping (_ sender: CustomSelectionButtons) -> Void) {
        self.actionOne = actionOne
        self.actionTwo = actionTwo
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
        setUpSelf()
        setUpTapGestureRecognisers()
    }
}
