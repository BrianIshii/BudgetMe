//
//  Category.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation
import UIKit

public class Category: Codable {
    private var name: String
    private var color: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case color
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        color = try container.decode(String.self, forKey: .color)
    }
    
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
