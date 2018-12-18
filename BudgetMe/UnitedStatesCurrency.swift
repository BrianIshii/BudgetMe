//
//  UnitedStatesCurrency.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class UnitedStatesCurrency : Currency {
    var dollars: Int
    var cents: Int
    
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
}