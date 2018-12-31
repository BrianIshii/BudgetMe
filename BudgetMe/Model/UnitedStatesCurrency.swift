//
//  UnitedStatesCurrency.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class UnitedStatesCurrency : Currency, Codable {
    private var dollars: Int
    private var cents: Int
    
    enum CodingKeys: Int, CodingKey {
        case dollars
        case cents
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dollars, forKey: .dollars)
        try container.encode(cents, forKey: .cents)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dollars = try container.decode(Int.self, forKey: .dollars)
        cents = try container.decode(Int.self, forKey: .cents)
    }
    
    init?(dollars: Int, cents: Int) {
        guard cents < 100 else {
            return nil
        }
        
        guard cents >= 0 else {
            return nil
        }

        guard dollars >= 0 else {
            return nil
        }
        
        self.dollars = dollars
        self.cents = cents
    }

    init?(total: String) {
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        
        let amountWithPrefix = regex.stringByReplacingMatches(in: total, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, total.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        
        let index = amountWithPrefix.index(amountWithPrefix.endIndex, offsetBy: -2)
        let centsString = (amountWithPrefix.suffix(from: index) as NSString).intValue
        
        self.dollars = Int(double / 100)
        self.cents = Int(centsString)
    }
    
    init() {
        dollars = 0
        cents = 0
    }
    
    public func display() -> String {
        var s: String
        if (cents > 9) {
            s = "$\(dollars).\(cents)"
        } else {
            s = "$\(dollars).0\(cents)"
        }
        print(s)
        return s
    }
    
    public func createCurrency(total: String) -> UnitedStatesCurrency {
        return UnitedStatesCurrency(total: total) ?? UnitedStatesCurrency()
    }
    
    public func currencyFormatter(total: String) -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = total
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: total, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, total.characters.count), withTemplate: "")
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "0.00"
        }
        
        return formatter.string(from: number)!
    }
    
    public func add(other: UnitedStatesCurrency) -> UnitedStatesCurrency {
        var totalCents = other.getCents() + cents
        var totalDollars = other.getDollars() + dollars

        if (totalCents > 99) {
            let extraDollars = totalCents / 100
            totalDollars += extraDollars
            totalCents -= extraDollars * 100
        }
        return UnitedStatesCurrency(dollars: totalDollars, cents: totalCents) ?? UnitedStatesCurrency()
    }
    
    public func getCents() -> Int {
        return cents
    }
    
    public func getDollars() -> Int {
        return dollars
    }
}
