//
//  Budget.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/30/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class Budget: Codable {
    public static var budgetFileName = "budgets"

    var total: UnitedStatesCurrency;
    var current: UnitedStatesCurrency;
    var name: String;
    
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
        name = try container.decode(String.self, forKey: .name)
    }
    
    init(total: UnitedStatesCurrency, name: String) {
        self.total = total
        self.current = UnitedStatesCurrency()
        self.name = name
    }
    
    public static func loadBudgetsOrDefault(fileName: String) -> [Budget] {
        if let savedBudgets = loadBudgets(fileName: fileName) {
            return savedBudgets
        } else {
            return loadSampleBudgets()
        }
    }
    
    private static func loadBudgets(fileName: String) -> [Budget]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Budget].self, from: data)
                return jsonData
            } catch {
                print("cannot load budgets")
            }
        }
        return nil
    }
    
    private static func loadSampleBudgets() -> [Budget] {
        let budget1 = Budget(total: UnitedStatesCurrency(dollars: 500, cents: 0) ?? UnitedStatesCurrency(), name: "Rent")
        let budget2 = Budget(total: UnitedStatesCurrency(dollars: 400, cents: 0) ?? UnitedStatesCurrency(), name: "Food")
        let budget3 = Budget(total: UnitedStatesCurrency(dollars: 100, cents: 0) ?? UnitedStatesCurrency(), name: "Gas")
        
        return [budget1, budget2, budget3]
    }
    
    public static func trySaveBudgets(budgets: [Budget]) {
        let didSave = saveBudgets(budgets: budgets)
        
        if (!didSave) {
            print("could not save budgets")
        }
    }
    
    private static func saveBudgets(budgets: [Budget]) -> Bool {
        if let url = Bundle.main.url(forResource: budgetFileName, withExtension: "json")  {
            let jsonData = try! JSONEncoder().encode(budgets)
            //print("saving")
            //let jsonString = String(data: jsonData, encoding: .utf8)!
            do {
                try jsonData.write(to: url, options: .atomic)
            } catch {
                return false
            }
        } else {
            return false
        }
        return true
    }
}
