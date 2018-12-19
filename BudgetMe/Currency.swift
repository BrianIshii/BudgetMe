//
//  Currency.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public protocol Currency {
    func display() -> String
    func createCurrency(total: String) -> Currency
}
