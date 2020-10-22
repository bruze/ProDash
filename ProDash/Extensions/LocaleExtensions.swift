//
//  LocaleExtensions.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/21/20.
//

import Foundation

extension Locale {
    static func locale(from currencyIdentifier: String) -> Locale? {
        let allLocales = Locale.availableIdentifiers.map({ Locale.init(identifier: $0) })
        return allLocales.filter({ $0.currencyCode == currencyIdentifier }).first
    }
}
