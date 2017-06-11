//
//  CountryDataSource.swift
//  Planet
//
//  Created by Mikael Konutgan on 15/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import Foundation

class CountryDataSource {
    let currentCountry: Country?
    
    private let countries: [[Country]]
    
    let locale: Locale
    let countryCodes: [String]
    
    init(locale: Locale = .current, countryCodes: [String] = Locale.isoRegionCodes) {
        self.locale = locale
        self.countryCodes = countryCodes
        
        var currentCountries: [Country] = []
        var otherCountries: [Country] = []
        
        let currentCountryCode = Country.currentCountryCode(currentSystemLocale: Locale.current, formattingLocale: locale)
        
        for countryCode in countryCodes {
            if let country = Country.find(isoCode: countryCode, locale: locale) {
                if country.isoCode == currentCountryCode {
                    currentCountries.append(country)
                } else {
                    otherCountries.append(country)
                }
            }
        }
        
        otherCountries.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        
        currentCountry = currentCountries.first
        countries = [currentCountries, otherCountries]
    }
    
    func sectionCount() -> Int {
        return countries.count
    }
    
    func count(_ section: Int) -> Int {
        return countries[section].count
    }
    
    func find(_ indexPath: IndexPath) -> Country {
        return countries[indexPath.section][indexPath.row]
    }
    
    func find(_ text: String) -> [Country] {
        return countries.joined()
            .filter { $0.name.localizedCaseInsensitiveContains(text) }
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
}
