//
//  Expenditure.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 9/10/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import Foundation
import UIKit

class ExpenditureClass: Codable {
    var amount: Double
    var isSpending: Bool
    var store: String
    var inputDate: Date
    
    init(amount: Double, isSpending: Bool, store: String, inputDate: Date) {
        self.amount = amount
        self.isSpending = isSpending
        self.store = store
        self.inputDate = inputDate
    }
    
    static func getArchiveURL() -> URL {
        let plistName = "expenditure"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(expenditures: [ExpenditureClass]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedExpenditures = try? propertyListEncoder.encode(expenditures)
        try? encodedExpenditures?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [ExpenditureClass]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedExpenditureData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedExpenditure = try? propertyListDecoder.decode(Array<ExpenditureClass>.self, from: retrievedExpenditureData) else { return nil }
        
        return decodedExpenditure
    }
    
    static func getIconAndColor(_ store :String) -> (img: UIImage, color: UIColor) {
        if store.lowercased().contains("steam") {
            return (img: UIImage(systemName: "gamecontroller.fill")!, color: #colorLiteral(red: 0.7882352941, green: 0.5490196078, blue: 0.6549019608, alpha: 1))
        } else if store.lowercased().contains("grab") {
            return (img: UIImage(systemName: "car.fill")!, color: #colorLiteral(red: 0.6431372549, green: 0.7647058824, blue: 0.6980392157, alpha: 1))
        } else if store.lowercased().contains("apple") {
            return (img: UIImage(systemName: "desktopcomputer")!, color: #colorLiteral(red: 0.8352941176, green: 0.6274509804, blue: 0.1294117647, alpha: 1))
        } else if store.lowercased().contains("amazon") {
            return (img: UIImage(systemName: "cube.box.fill")!, color: #colorLiteral(red: 0.9725490196, green: 0.4392156863, blue: 0.3764705882, alpha: 1))
        } else if store.lowercased().contains("hardware") || store.lowercased().contains("construction") {
            return (img: UIImage(systemName: "wrench.fill")!, color: #colorLiteral(red: 0.8352941176, green: 0.6274509804, blue: 0.1294117647, alpha: 1))
        }
        
        return (img: UIImage(systemName: "dollarsign.circle.fill")!, color: #colorLiteral(red: 0.7882352941, green: 0.5490196078, blue: 0.6549019608, alpha: 1))
    }
}
