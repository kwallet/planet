//
//  PlanetTests.swift
//  PlanetTests
//
//  Created by Mikael Konutgan on 14/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import XCTest
@testable import Planet

class PlanetTests: XCTestCase {
    
    func testFindingAustria() {
        let locale = Locale(identifier: "de_AT")
        let dataSource = CountryDataSource(locale: locale)
        
        let country = dataSource.find("Österreich").first

        XCTAssertEqual(country?.name, "Österreich")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }
    
    func testFindingGermany() {
        let locale = Locale(identifier: "de_AT")
        let dataSource = CountryDataSource(locale: locale)
        
        let country = dataSource.find("Schland").first
        
        XCTAssertEqual(country?.name, "Deutschland")
        XCTAssertEqual(country?.isoCode, "DE")
        XCTAssertEqual(country?.callingCode, "+49")
    }
    
    func testFindingAustriaInEnglish() {
        let locale = Locale(identifier: "en_US")
        let dataSource = CountryDataSource(locale: locale)
        
        let country = dataSource.find("Austria").first
        
        XCTAssertEqual(country?.name, "Austria")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }

    func testUnfilteredCountryCount() {
        let locale = Locale(identifier: "de_AT")
        let dataSource = CountryDataSource(locale: locale)

        let dataAsset = NSDataAsset(name: "country-calling-codes", bundle: .planetBundle())!
        let callingCodes = (try? JSONSerialization.jsonObject(with: dataAsset.data, options: [])) as! [String: String]


        XCTAssertEqual(dataSource.count(0), 1) // current locale
        XCTAssertEqual(dataSource.count(1), callingCodes.count - 1) // the rest
    }

    func testFilterCountryCount() {
        let filterArray = ["AT", "DE", "US"]
        let locale = Locale(identifier: "en_GB")
        let dataSource = CountryDataSource(locale: locale, filteredISOCodes: filterArray)

        XCTAssertEqual(dataSource.count(0), 0) // current locale - not in filterArray
        XCTAssertEqual(dataSource.count(1), 3) // the rest
    }
}
