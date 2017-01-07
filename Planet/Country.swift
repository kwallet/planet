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
    
    public static var locale: Locale = .current
    
    var image: UIImage? {
        let imageName = isoCode
        let bundle = Bundle.planetBundle()
        
        return UIImage(named: imageName, in: bundle, compatibleWith: nil)
    }
    
    public static var countries: [Country] = {
        
        let dataAsset = NSDataAsset(name: "country-calling-codes", bundle: .planetBundle())!
        let callingCodes = (try? JSONSerialization.jsonObject(with: dataAsset.data, options: [])) as! [String: String]
        
        var countries: [Country] = []
        
        for countryCode in Locale.isoRegionCodes {
            guard let countryName = (Country.locale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode) else {
                continue
            }
            
            guard let callingCode = callingCodes[countryCode] else {
                continue
            }
            
            let country = Country(name: countryName, isoCode: countryCode, callingCode: "+\(callingCode)")
            
            countries.append(country)
        }
        
        countries.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        return countries
    }()
    
    public static func find(isoCode: String) -> Country? {
        return Country.countries
            .filter { $0.isoCode == isoCode }
            .first
    }
    
    public static func find(callingCode: String) -> Country? {
        return Country.countries
            .filter { $0.callingCode == callingCode }
            .first
    }
}
