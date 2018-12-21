//
//  Currency.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public protocol Currency: Codable {
    func display() -> String
    func createCurrency(total: String) -> UnitedStatesCurrency
    func encode(to encoder: Encoder) throws
    func currencyFormatter(total: String) -> String
}
