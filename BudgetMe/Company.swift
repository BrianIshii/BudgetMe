//
//  Company.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
public class Company {
    private var name: String
    
    init() {
        self.name = "Default Company"
    }
    
    init(name: String) {
        self.name = name
    }
    
    func display() -> String {
        return name
    }
}
