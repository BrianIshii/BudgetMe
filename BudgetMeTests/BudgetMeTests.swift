//
//  BudgetMeTests.swift
//  BudgetMeTests
//
//  Created by Brian Ishii on 12/17/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import XCTest
@testable import BudgetMe

class BudgetMeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUnitedStatesCurrencyInitializationFails() {
        
        // 100 cents
        let oneHundredCents = UnitedStatesCurrency.init(dollars: 1, cents: 100)
        XCTAssertNil(oneHundredCents)
        
        // 101 cents
        let oneHundredAndOneCents = UnitedStatesCurrency.init(dollars: 1, cents: 101)
        XCTAssertNil(oneHundredAndOneCents)
        
        // negative cents
        let negativeCents = UnitedStatesCurrency.init(dollars: 1, cents: -1)
        XCTAssertNil(negativeCents)
        
        //negative dollars
        let negativeDollars = UnitedStatesCurrency.init(dollars: -1, cents: 0)
        XCTAssertNil(negativeDollars)
    }
    
    func testUnitedStatesCurrencyInitializationSucceeds() {
        
        // positive dollars and cents
        let positiveDollarsAndCents = UnitedStatesCurrency.init(dollars: 10, cents: 20);
        XCTAssertNotNil(positiveDollarsAndCents)
        
        // 0 dollars and 0 cents
        let zeroDollarsAndZeroCents = UnitedStatesCurrency.init(dollars: 0, cents: 0);
        XCTAssertNotNil(zeroDollarsAndZeroCents)
        
        // 1 dollar and 99 cents
        let oneDollarsAndNinetyNineCents = UnitedStatesCurrency.init(dollars: 1, cents: 99);
        XCTAssertNotNil(oneDollarsAndNinetyNineCents)
    }
    
    func testUnitedStatesCurrencyDisplay() {
        // positive dollars and cents
        let positiveDollarsAndCents = UnitedStatesCurrency.init(dollars: 10, cents: 20);
        if let output = positiveDollarsAndCents?.display() {
            XCTAssert(output == "$10.20")
        } else {
            XCTAssert(false)
        }
        
        // 0 dollars and 0 cents
        let zeroDollarsAndZeroCents = UnitedStatesCurrency.init(dollars: 0, cents: 0);
        XCTAssertNotNil(zeroDollarsAndZeroCents)
        if let output = zeroDollarsAndZeroCents?.display() {
            XCTAssert(output == "$0.00")
        } else {
            XCTAssert(false)
        }
        
        // 1 dollar and 99 cents
        let oneDollarsAndNinetyNineCents = UnitedStatesCurrency.init(dollars: 1, cents: 99);
        XCTAssertNotNil(oneDollarsAndNinetyNineCents)
        if let output = oneDollarsAndNinetyNineCents?.display() {
            XCTAssert(output == "$1.99")
        } else {
            XCTAssert(false)
        }
        
        // 1 dollar and 9 cents
        let oneDollarsAndNineCents = UnitedStatesCurrency.init(dollars: 1, cents: 9);
        XCTAssertNotNil(oneDollarsAndNineCents)
        if let output = oneDollarsAndNineCents?.display() {
            XCTAssert(output == "$1.09")
        } else {
            XCTAssert(false)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
