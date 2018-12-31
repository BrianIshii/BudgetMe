//
//  PurchaseDatabaseAccess.swift
//  BudgetMe
//
//  Created by Brian Ishii on 12/31/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class PurchaseDatabaseAccess {
    private static let purchaseFileName = "purchases"

    init() {
        
    }
    
    public static func loadPurchasesOrDefault() -> [Purchase] {
        if let savedPurchases = loadPurchases() {
            return savedPurchases
        } else {
            return loadSamplePurchases()
        }
    }
    
    private static func loadSamplePurchases() -> [Purchase] {
        let purchase1 = Purchase(total: UnitedStatesCurrency(dollars: 1, cents: 9) ?? UnitedStatesCurrency(), company: Company(name: "McDonald's"), category: PurchaseCategory(name: "food", color: "blue"), paymentType: PaymentType())
        
        let purchase2 = Purchase(total: UnitedStatesCurrency(dollars: 10, cents: 99) ?? UnitedStatesCurrency(), company: Company(name: "Game Stop"), category: PurchaseCategory(name: "games", color: "red"), paymentType: PaymentType())
        
        let purchase3 = Purchase(total: UnitedStatesCurrency(dollars: 40, cents: 00) ?? UnitedStatesCurrency(), company: Company(name: "Shell"), category: PurchaseCategory(name: "car", color: "green"), paymentType: PaymentType())
        
        return [purchase1, purchase2, purchase3]
    }
    
    private static func loadPurchases() -> [Purchase]? {
        if let url = Bundle.main.url(forResource: purchaseFileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Purchase].self, from: data)
                return jsonData
            } catch {
                print("cannot load purchases")
            }
        }
        return nil
    }
    
    public static func trySavePurchases(purchases: [Purchase]) {
        let didSave = savePurchases(purchases: purchases)
        
        if (!didSave) {
            print("could not save purchases")
        }
    }
    
    private static func savePurchases(purchases: [Purchase]) -> Bool {
        if let url = Bundle.main.url(forResource: purchaseFileName, withExtension: "json")  {
            let jsonData = try! JSONEncoder().encode(purchases)
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
