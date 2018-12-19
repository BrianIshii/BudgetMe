//
//  UnitedStatesCurrency.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class UnitedStatesCurrency : Currency, Codable {
    var dollars: Int
    var cents: Int
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
        let number = Int(total)
        if (number != nil) {
            return UnitedStatesCurrency(dollars: number ?? 0, cents: 0) ?? UnitedStatesCurrency()
        }
        return UnitedStatesCurrency()
    }
}
