//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Diego Sierra on 22/10/23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
