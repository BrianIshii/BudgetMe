//
//  Company.swift
//  BudgeMe
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import Foundation

public class Company: Codable {
    private var name: String
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
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
