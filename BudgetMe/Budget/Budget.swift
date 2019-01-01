//
//  Budget.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/30/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class Budget: Codable {
    
    var total: UnitedStatesCurrency;
    var current: UnitedStatesCurrency;
    var name: BudgetCategory;
    
    enum CodingKeys: String, CodingKey {
        case total
        case current
        case name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(total, forKey: .total)
        try container.encode(current, forKey: .current)
        try container.encode(name, forKey: .name)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decode(UnitedStatesCurrency.self, forKey: .total)
        current = try container.decode(UnitedStatesCurrency.self, forKey: .current)
        name = try container.decode(BudgetCategory.self, forKey: .name)
    }
    
    init(total: UnitedStatesCurrency, name: String) {
        self.total = total
        self.current = UnitedStatesCurrency()
        self.name = BudgetCategory(name: name, color: "blue")
    }
}
