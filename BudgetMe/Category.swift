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
    private var color: UIColor
    
    init() {
        self.name = ""
        self.color = UIColor.white
    }
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    func display() -> String {
        return name
    }
    
    func displayColor() -> UIColor {
        return color
    }
    
}
