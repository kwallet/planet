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
        Country.locale = locale
        
        var currentCountries: [Country] = []
        var otherCountries: [Country] = []
        
        let currentCountryCode = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
        
        for countryCode in countryCodes {
            let country = Country.countries.filter{$0.isoCode == countryCode}.first
            if country != nil {
                if country!.isoCode == currentCountryCode {
                    currentCountries.append(country!)
                } else {
                    otherCountries.append(country!)
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
        return countries[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
    }
    
    func find(_ text: String) -> [Country] {
        return countries.joined()
            .filter { $0.name.localizedCaseInsensitiveContains(text) }
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
}
