//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Kevin  Watke on 1/17/22.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
	var formatter: CurrencyFormatter!
	
	override func setUp() {
		super.setUp()
		formatter = CurrencyFormatter()
	}
	
	
	func testBreakDollarsIntoCents() throws {
		let result = formatter.breakIntoDollarsAndCents(929466.23)
		XCTAssertEqual(result.0, "929,466")
		XCTAssertEqual(result.1, "23")
	}
	
	
	func testDollarsFormatted() {
		let result = formatter.dollarsFormatted(929466.23)
		XCTAssertEqual(result, "$929,466.23")
	}
}
