//
//  SummaryViewController.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 25/10/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    // Current Balance
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var currentBalanceProgressLabel: UILabel!
    @IBOutlet weak var currentBalanceIconImageView: UIImageView!
    
    // Expenditure
    @IBOutlet weak var expenditureLabel: UILabel!
    @IBOutlet weak var expenditureProgressLabel: UILabel!
    @IBOutlet weak var expenditureIconImageView: UIImageView!
    
    // CashFlow table
    @IBOutlet var positiveCashFlowHeightConstraints: [NSLayoutConstraint]!
    @IBOutlet var negativeCashFlowHeightConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var upperboundOne: UILabel!
    @IBOutlet weak var upperboundTwo: UILabel!
    @IBOutlet weak var zero: UILabel!
    @IBOutlet weak var lowerboundOne: UILabel!
    @IBOutlet weak var lowerboundTwo: UILabel!
    
    let maxHeight = (UIScreen.main.bounds.height - 427.5)/2
    
    var spendingDayInformation: [Double] = [0, 0, 0, 0, 0, 30, 0]
    var savingsDayInformation: [Double] = [0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        updateData()
    }
    
    func updateData() {
        let expenditure = ExpenditureClass.loadFromFile() ?? []
        
        for i in expenditure {
            let calendar = Calendar.current
            
            let amount = i.amount
            
            if !i.isSpending {
                savingsDayInformation[calendar.component(.weekday, from: i.inputDate)] += amount
            } else {
                spendingDayInformation[calendar.component(.weekday, from: i.inputDate)] += amount
            }
            
        }
        
        let balance = savingsDayInformation.reduce(0, +) - spendingDayInformation.reduce(0, +)
        if balance < 0 {
             currentBalanceLabel.text = "-$" + String(balance * -1)
        } else {
            currentBalanceLabel.text = "$" + String(balance)
        }
        
        expenditureLabel.text = "$" + String(spendingDayInformation.reduce(0, +))
        
        upperboundOne.text = "$\(spendingDayInformation.sorted().last! / 3 * 2)"
        upperboundTwo.text = "$\(spendingDayInformation.sorted().last! / 3)"
        
        lowerboundOne.text = "-$\(spendingDayInformation.sorted().last! / 3)"
        lowerboundTwo.text = "-$\(spendingDayInformation.sorted().last! / 3 * 2)"
        
        for i in 0...positiveCashFlowHeightConstraints.count - 1 {
            print(maxHeight)
            print(spendingDayInformation.sorted())
            
            if spendingDayInformation.sorted().last == 0 {
                negativeCashFlowHeightConstraints[i].constant = 0
            } else {
                negativeCashFlowHeightConstraints[i].constant = (maxHeight / CGFloat(spendingDayInformation.sorted().last!)) * CGFloat(spendingDayInformation[i])
            }
            
            if savingsDayInformation.sorted().last == 0 {
                positiveCashFlowHeightConstraints[i].constant = 0
            } else {
                positiveCashFlowHeightConstraints[i].constant = (maxHeight / CGFloat(savingsDayInformation.sorted().last!)) * CGFloat(savingsDayInformation[i])
            }
        }
        
        print(spendingDayInformation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
