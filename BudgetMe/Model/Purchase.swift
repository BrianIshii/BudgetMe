//
//  Purchase.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class Purchase: Codable {
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //static let ArchiveURL = DocumentsDirectory.appendingPathComponent(fileName)

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
}
