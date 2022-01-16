//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Kevin  Watke on 1/17/22.
//

import Foundation

extension Decimal {
	var doubleValue: Double {
		return NSDecimalNumber(decimal: self).doubleValue
	}
}
