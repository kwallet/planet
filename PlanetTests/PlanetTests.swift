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
        let locale = NSLocale(localeIdentifier: "de_AT")
        let dataSource = CountryDataSource(locale: locale)
        
        let country = dataSource.find("Österreich").first

        XCTAssertEqual(country?.name, "Österreich")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }
    
    func testFindingGermany() {
        let locale = NSLocale(localeIdentifier: "de_AT")
        let dataSource = CountryDataSource(locale: locale)
        
        let country = dataSource.find("Schland").first
        
        XCTAssertEqual(country?.name, "Deutschland")
        XCTAssertEqual(country?.isoCode, "DE")
        XCTAssertEqual(country?.callingCode, "+49")
    }
    
    func testFindingAustriaInEnglish() {
        let locale = NSLocale(localeIdentifier: "en_US")
        let dataSource = CountryDataSource(locale: locale)
        
        let country = dataSource.find("Austria").first
        
        XCTAssertEqual(country?.name, "Austria")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }
}
