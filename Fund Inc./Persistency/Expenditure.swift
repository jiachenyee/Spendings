//
//  Expenditure.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 9/10/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import Foundation

struct Expenditure: Codable {
    var amount: Double
    var isSpending: Bool
    var store: String
}

class ExpenditureClass: Codable {
    var amount: Double
    var isSpending: Bool
    var store: String
    
    init(amount: Double, isSpending: Bool, store: String) {
        self.amount = amount
        self.isSpending = isSpending
        self.store = store
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
    
}
