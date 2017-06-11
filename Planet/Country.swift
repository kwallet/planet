//
//  Country.swift
//  Planet
//
//  Created by Mikael Konutgan on 15/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import UIKit

public struct Country {
    public let name: String
    public let isoCode: String
    public let callingCode: String
}

public extension Country {
    var image: UIImage? {
        let imageName = isoCode
        let bundle = Bundle.planetBundle()
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
}

extension Country {
    private static var localizedCountries: [Locale : [Country]] = [:]
    private static var callingCodes: [String: String] = [:]
    
    public static func all(locale: Locale = .current) -> [Country] {
        if let countries = localizedCountries[locale] {
            return countries
        }
        
        if callingCodes.isEmpty {
            let dataAsset = NSDataAsset(name: "country-calling-codes", bundle: .planetBundle())!
            callingCodes = (try? JSONSerialization.jsonObject(with: dataAsset.data, options: [])) as! [String: String]
        }
        
        var countries: [Country] = []
        
        for countryCode in Locale.isoRegionCodes {
            guard let countryName = (locale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode) else {
                continue
            }
            
            guard let callingCode = callingCodes[countryCode] else {
                continue
            }
            
            let country = Country(name: countryName, isoCode: countryCode, callingCode: "+\(callingCode)")
            
            countries.append(country)
        }
        
        countries.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        
        localizedCountries[locale] = countries
        
        return countries
    }
    
    public static func find(isoCode: String, locale: Locale = .current) -> Country? {
        return all(locale: locale).filter { $0.isoCode == isoCode } .first
    }
    
    public static func find(callingCode: String, locale: Locale = .current) -> Country? {
        return all(locale: locale).filter { $0.callingCode == callingCode } .first
    }

    public static func currentCountryCode(currentSystemLocale: Locale = .current, formattingLocale: Locale = .current) -> String? {
        if let countryCode = (currentSystemLocale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String {
            return countryCode
        }
        return (formattingLocale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
}
