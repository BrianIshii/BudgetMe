//
//  Purchase.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
class Purchase {
    var total: Currency;
    var company: Company;
    var category: Category;
    var paymentType: PaymentType;

    init() {
        self.total = UnitedStatesCurrency();
        self.company = Company();
        self.category = Category();
        self.paymentType = PaymentType();
    }
    
    init(total: Currency, company: Company, category: Category, paymentType: PaymentType) {
        self.total = total;
        self.company = company;
        self.category = category;
        self.paymentType = paymentType;
    }
    
}
