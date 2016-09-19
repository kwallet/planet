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
    
    init(locale: Locale = .current) {
        let countryCodes = Locale.isoRegionCodes
        
        let dataAsset = NSDataAsset(name: "country-calling-codes", bundle: .planetBundle())!
        let callingCodes = (try? JSONSerialization.jsonObject(with: dataAsset.data, options: [])) as! [String: String]
        
        var currentCountries: [Country] = []
        var otherCountries: [Country] = []
        
        let currentCountryCode = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String
        
        for countryCode in countryCodes {
            guard let countryName = (locale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode) else {
                continue
            }
            
            guard let callingCode = callingCodes[countryCode] else {
                continue
            }
            
            let country = Country(name: countryName, isoCode: countryCode, callingCode: "+\(callingCode)")
            
            if country.isoCode == currentCountryCode {
                currentCountries.append(country)
            } else {
                otherCountries.append(country)
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
