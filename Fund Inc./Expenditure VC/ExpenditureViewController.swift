//
//  ExpenditureViewController.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 13/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit

class ExpenditureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpView: PopUpView!
    @IBOutlet weak var customSelectionView: CustomSelectionButtons!
    @IBOutlet weak var summaryContainerView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customSelectionView.addAction(actionOne: { (actionOne) in
            // Launch OCR
            
        }) { (actionTwo) in
            // Launch Pop-up
            self.popUpView.isHidden = false
        }
        
        popUpView.completion = { (_) in
            self.tableView.reloadData()
        }
        
        popFrame = popUpView.frame
        customSelectionView.tintColor = .black
    }
    
    // MARK: TableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ExpenditureClass.loadFromFile() ?? []).count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (ExpenditureClass.loadFromFile() ?? []).count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filler", for: indexPath)
            return cell
        }
        
        let data = ExpenditureClass.loadFromFile() ?? []
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendings", for: indexPath) as! SpendingsTableViewCell
        
        cell.iconImageView.image = ExpenditureClass.getIconAndColor(data[indexPath.row].store).img
        cell.curvedImageViewView.backgroundColor = ExpenditureClass.getIconAndColor(data[indexPath.row].store).color
        cell.titleLabel.text = data[indexPath.row].store
        
        // Setting the time
        var time = ""
        
        if data[indexPath.row].inputDate.timeIntervalSinceNow / 86400 <= 0 {
            time = "Today"
        } else if data[indexPath.row].inputDate.timeIntervalSinceNow / 86400 <= 1 {
            time = "Yesterday"
        } else {
            time = "\(data[indexPath.row].inputDate.timeIntervalSinceNow / 86400) days ago"
        }
        
        cell.costAndTimeLabel.text = "$\(String(format: "%.2f", data[indexPath.row].amount)) | \(time)"
        
        if data[indexPath.row].isSpending {
            cell.costAndTimeLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
            cell.arrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            cell.arrowImageView.tintColor = #colorLiteral(red: 0.8588235294, green: 0.3294117647, blue: 0.3803921569, alpha: 1)
        } else {
            cell.costAndTimeLabel.textColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1)
            cell.arrowImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            cell.arrowImageView.tintColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.6, alpha: 1)
        }
        
        return cell
    }
    
    // MARK: - Optical Character Recognition
    
    // MARK: - Setting the Scanning View Controllers
    
    // MARK: - Scan Handling
    /// Recognizes and displays the text from the image
    /// - Parameter image: `UIImage` to process and perform OCR on
    
    // MARK: - Image Loading Workaround
}

