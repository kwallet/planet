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
    
    init(locale: NSLocale = .currentLocale()) {
        let countryCodes = NSLocale.ISOCountryCodes()
        
        let dataAsset = NSDataAsset(name: "country-calling-codes", bundle: .planetBundle())!
        let callingCodes = (try? NSJSONSerialization.JSONObjectWithData(dataAsset.data, options: [])) as! [String: String]
        
        var currentCountries: [Country] = []
        var otherCountries: [Country] = []
        
        let currentCountryCode = locale.objectForKey(NSLocaleCountryCode) as! String
        
        for countryCode in countryCodes {
            guard let countryName = locale.displayNameForKey(NSLocaleCountryCode, value: countryCode) else {
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
        
        otherCountries.sortInPlace { $0.name.localizedCaseInsensitiveCompare($1.name) == .OrderedAscending }
        
        currentCountry = currentCountries.first
        countries = [currentCountries, otherCountries]
    }
    
    func sectionCount() -> Int {
        return countries.count
    }
    
    func count(section: Int) -> Int {
        return countries[section].count
    }
    
    func find(indexPath: NSIndexPath) -> Country {
        return countries[indexPath.section][indexPath.row]
    }
    
    func find(text: String) -> [Country] {
        return countries.flatten()
            .filter { $0.name.localizedCaseInsensitiveContainsString(text) }
            .sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .OrderedAscending }
    }
}
