//
//  UnitedStatesCurrencyTests.swift
//  BudgetMeTests
//
//  Created by Brian Ishii on 12/30/18.
//  Copyright © 2018 Brian Ishii. All rights reserved.
//

import XCTest
@testable import BudgetMe

class UnitedStatesCurrencyTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUnitedStatesCurrencyInitializationFails() {
        
        // 100 cents
        let oneHundredCents = UnitedStatesCurrency(dollars: 1, cents: 100)
        XCTAssertNil(oneHundredCents)
        
        // 101 cents
        let oneHundredAndOneCents = UnitedStatesCurrency(dollars: 1, cents: 101)
        XCTAssertNil(oneHundredAndOneCents)
        
        // negative cents
        let negativeCents = UnitedStatesCurrency(dollars: 1, cents: -1)
        XCTAssertNil(negativeCents)
        
        //negative dollars
        let negativeDollars = UnitedStatesCurrency(dollars: -1, cents: 0)
        XCTAssertNil(negativeDollars)
    }
    
    func testUnitedStatesCurrencyInitializationSucceeds() {
        
        // positive dollars and cents
        let positiveDollarsAndCents = UnitedStatesCurrency(dollars: 10, cents: 20);
        XCTAssertNotNil(positiveDollarsAndCents)
        
        // 0 dollars and 0 cents
        let zeroDollarsAndZeroCents = UnitedStatesCurrency(dollars: 0, cents: 0);
        XCTAssertNotNil(zeroDollarsAndZeroCents)
        
        // 1 dollar and 99 cents
        let oneDollarsAndNinetyNineCents = UnitedStatesCurrency(dollars: 1, cents: 99);
        XCTAssertNotNil(oneDollarsAndNinetyNineCents)
    }
    
    func testUnitedStatesCurrencyDisplay() {
        // positive dollars and cents
        let positiveDollarsAndCents = UnitedStatesCurrency(dollars: 10, cents: 20);
        if let output = positiveDollarsAndCents?.display() {
            XCTAssert(output == "$10.20")
        } else {
            XCTAssert(false)
        }
        
        // 0 dollars and 0 cents
        let zeroDollarsAndZeroCents = UnitedStatesCurrency(dollars: 0, cents: 0);
        XCTAssertNotNil(zeroDollarsAndZeroCents)
        if let output = zeroDollarsAndZeroCents?.display() {
            XCTAssert(output == "$0.00")
        } else {
            XCTAssert(false)
        }
        
        // 1 dollar and 99 cents
        let oneDollarsAndNinetyNineCents = UnitedStatesCurrency(dollars: 1, cents: 99);
        XCTAssertNotNil(oneDollarsAndNinetyNineCents)
        if let output = oneDollarsAndNinetyNineCents?.display() {
            XCTAssert(output == "$1.99")
        } else {
            XCTAssert(false)
        }
        
        // 1 dollar and 9 cents
        let oneDollarsAndNineCents = UnitedStatesCurrency(dollars: 1, cents: 9);
        XCTAssertNotNil(oneDollarsAndNineCents)
        if let output = oneDollarsAndNineCents?.display() {
            XCTAssert(output == "$1.09")
        } else {
            XCTAssert(false)
        }
    }
    
    func testUnitedStatesCurrencyAdd() {
        
        // adding two currencies with more than 100 cents
        let currencyOne = UnitedStatesCurrency(dollars: 1, cents: 9);
        let currencyTwo = UnitedStatesCurrency(dollars: 2, cents: 99);
        if let output = currencyOne?.add(other: currencyTwo ?? UnitedStatesCurrency()) {
            XCTAssert(output.display() == "$4.08")
        } else {
            XCTAssert(false)
        }
        
        // adding two currencies with more than 100 cents
        let currencyThree = UnitedStatesCurrency(dollars: 1, cents: 9);
        let currencyFour = UnitedStatesCurrency(dollars: 2, cents: 10);
        if let output = currencyThree?.add(other: currencyFour ?? UnitedStatesCurrency()) {
            XCTAssert(output.display() == "$3.19")
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
