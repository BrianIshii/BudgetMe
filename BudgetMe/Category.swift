//
//  Category.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

public class Category {
    private var name: String
    private var color: String
    
    init() {
        self.name = ""
        self.color = "white"
    }
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    func display() -> String {
        return name
    }
    
    func displayColor() -> String {
        return color
    }
    
}
