//
//  BudgetDatabaseAccess.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/31/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class BudgetDatabaseAccess {
    private static var budgetFileName = "budgets"

    init() {
        
    }
    
    // load budgets
    public static func loadBudgetsOrDefault() -> [Budget] {
        if let savedBudgets = loadBudgets() {
            return savedBudgets
        } else {
            return loadSampleBudgets()
        }
    }
    
    private static func loadSampleBudgets() -> [Budget] {
        let budget1 = Budget(total: UnitedStatesCurrency(dollars: 500, cents: 0) ?? UnitedStatesCurrency(), name: "Rent")
        let budget2 = Budget(total: UnitedStatesCurrency(dollars: 400, cents: 0) ?? UnitedStatesCurrency(), name: "Food")
        let budget3 = Budget(total: UnitedStatesCurrency(dollars: 100, cents: 0) ?? UnitedStatesCurrency(), name: "Gas")
        
        return [budget1, budget2, budget3]
    }
    
    private static func loadBudgets() -> [Budget]? {
        if let url = Bundle.main.url(forResource: budgetFileName, withExtension: "json") {
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
    
    // save budgets
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
