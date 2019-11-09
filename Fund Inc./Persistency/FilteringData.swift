//
//  FilteringData.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 7/11/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import Foundation

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    func indicesOf(string: String) -> [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        
        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        
        return indices
    }

}


func extractReceiptInformation(with data: String) -> (store: String, total: Double) {
    let splitWithNewLines = data.split(separator: "\n")
    var returnedValue = (store: "", total: 0.0)
    
    // Get store name
    // Ignore Tax Invoice
    // Ignore Receipt
    let lowercasedData = String(splitWithNewLines[0]).removeWhitespace().lowercased()
    if lowercasedData.contains("taxinvoice") || lowercasedData.contains("receipt") {
        // Next line is store name
        returnedValue.store = String(splitWithNewLines[1])
    } else {
        returnedValue.store = String(splitWithNewLines[0])
    }
    
    let newSplitWithLines = data.removeWhitespace().lowercased().split(separator: "\n")
    
    var getNextLine = false
    
    // Find the word to find
    var find = "total"
    
    if data.removeWhitespace().lowercased().contains("grandtotal") {
        find = "grandtotal"
    }
    
    for i in newSplitWithLines {
        if getNextLine {
            let newI = i.filter { (str) -> Bool in
                return !str.isLetter && str != "$"
            }
            print(newI)
            if let value = Double(newI) {
                returnedValue.total = value
                break
            }
        } else {
            if i.contains(find) && !(i.contains("-")) {
                getNextLine = true
            }
        }
    }
    
    // Search for total
    return returnedValue
}
