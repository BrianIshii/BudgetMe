//
//  Purchase.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
class Purchase: Codable {
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("purchases")
    
    var total: UnitedStatesCurrency;
    var company: Company;
    var category: PurchaseCategory;
    var paymentType: PaymentType;
    
    enum CodingKeys: String, CodingKey {
        case total
        case company
        case category
        case paymentType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(total, forKey: .total)
        try container.encode(company, forKey: .company)
        try container.encode(category, forKey: .category)
        try container.encode(paymentType, forKey: .paymentType)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decode(UnitedStatesCurrency.self, forKey: .total)
        company = try container.decode(Company.self, forKey: .company)
        category = try container.decode(PurchaseCategory.self, forKey: .category)
        paymentType = try container.decode(PaymentType.self, forKey: .paymentType)
    }
    
    init() {
        self.total = UnitedStatesCurrency();
        self.company = Company();
        self.category = PurchaseCategory();
        self.paymentType = PaymentType();
    }
    
    init(total: UnitedStatesCurrency, company: Company, category: PurchaseCategory, paymentType: PaymentType) {
        self.total = total;
        self.company = company;
        self.category = category;
        self.paymentType = paymentType;
    }
    
    public static func loadPurchasesOrDefault(fileName: String) -> [Purchase] {
        if let savedPurchases = Purchase.loadPurchases(fileName: fileName) {
            return savedPurchases
        } else {
            return Purchase.loadSamplePurchases()
        }
    }
    
    private static func loadPurchases(fileName: String) -> [Purchase]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Purchase].self, from: data)
                return jsonData
            } catch {
                print("cannot load purchases method")
            }
        }
        return nil
    }
    
    private static func loadSamplePurchases() -> [Purchase] {
        let purchase1 = Purchase(total: UnitedStatesCurrency(dollars: 1, cents: 9) ?? UnitedStatesCurrency(), company: Company(name: "McDonald's"), category: PurchaseCategory(name: "food", color: "blue"), paymentType: PaymentType())
        
        let purchase2 = Purchase(total: UnitedStatesCurrency(dollars: 10, cents: 99) ?? UnitedStatesCurrency(), company: Company(name: "Game Stop"), category: PurchaseCategory(name: "games", color: "red"), paymentType: PaymentType())
        
        let purchase3 = Purchase(total: UnitedStatesCurrency(dollars: 40, cents: 00) ?? UnitedStatesCurrency(), company: Company(name: "Shell"), category: PurchaseCategory(name: "car", color: "green"), paymentType: PaymentType())
        
        return [purchase1, purchase2, purchase3]
    }
}
