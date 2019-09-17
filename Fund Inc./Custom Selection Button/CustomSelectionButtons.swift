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
    
    // MARK: Actions
    
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
    
    
    // MARK: IB Options
    
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
    
    
    // MARK: UI Elements
    
    // Tap Gesture Recognisers
    private var tapGestureRecogniserOne: UITapGestureRecognizer = UITapGestureRecognizer()
    private var tapGestureRecogniserTwo: UITapGestureRecognizer = UITapGestureRecognizer()
    
    // Getting from NIB
    // because I am a lazy person to programmetically do this
    lazy private var screen: CustomSelectionButtonsView = {
        let xib = Bundle.main.loadNibNamed("CustomSelectionButtons", owner: self, options: nil)
        let me = xib![0] as! CustomSelectionButtonsView
        
        return me
    }()
    
    
    // MARK: Code Options
    
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
        setUpSelf()
        setUpTapGestureRecognisers()
    }
    
    
    private func setUpSelf() {
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
    
    
    // MARK: Tap Gesture Recogniser
    
    private func setUpTapGestureRecognisers() {
        // Setting the actions on the tap gesture recogniser
        tapGestureRecogniserOne.addTarget(self, action: #selector(actionOneClicked))
        tapGestureRecogniserTwo.addTarget(self, action: #selector(actionTwoClicked))
        
        screen.buttonOne.addGestureRecognizer(tapGestureRecogniserOne)
        screen.buttonTwo.addGestureRecognizer(tapGestureRecogniserTwo)
    }
    
    // Tap gesture recogniser actions
    // Apparently you cannot just cast a block into selector so here's the method...
    // Creating a function that just runs the block
    @objc private func actionOneClicked() {
        actionOne(self)
    }
    
    @objc private func actionTwoClicked() {
        actionTwo(self)
    }
}
