//
//  DoubleExtensions.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/21/20.
//

import Foundation

extension Double {
    var currencyFormat: (String) -> String {
        return { currencyCode in
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            if let locale = Locale.locale(from: currencyCode) {
                currencyFormatter.locale = locale
            }
            return currencyFormatter.string(from: NSNumber(value: self)) ?? ""
        }
    }
}
