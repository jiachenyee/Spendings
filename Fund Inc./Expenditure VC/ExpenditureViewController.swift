//
//  ViewController.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 13/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit

class ExpenditureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var popUpView: PopUpView!
    @IBOutlet weak var customSelectionView: CustomSelectionButtons!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        customSelectionView.addAction(actionOne: { (actionOne) in
            // Launch OCR
            
        }) { (actionTwo) in
            // Launch Pop-up
            self.popUpView.isHidden = false
            
        }
        popFrame = popUpView.frame
        customSelectionView.tintColor = .black
    }
    
    // MARK: TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filler", for: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendings", for: indexPath) as! SpendingsTableViewCell
        
        cell.iconImageView.image = UIImage(systemName: "desktopcomputer")
        cell.curvedImageViewView.backgroundColor = #colorLiteral(red: 0.6431372549, green: 0.7647058824, blue: 0.6980392157, alpha: 1)
        cell.titleLabel.text = "Store"
        cell.costAndTimeLabel.text = "$1,000 | Today"
        cell.costAndTimeLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
        cell.arrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        cell.arrowImageView.tintColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
        
        return cell
    }
    
}

