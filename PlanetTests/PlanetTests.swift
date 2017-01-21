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
        
        let country = dataSource.find("Österre").first
        
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
    
    func testDataSourceWithCustomCountryCodes() {
        let locale = Locale(identifier: "en_US")
        let dataSource = CountryDataSource(locale: locale, countryCodes: ["AT", "DE", "CH"])
        
        XCTAssertEqual(dataSource.count(1), 3)
        
        let includedCountry = dataSource.find("Austria").first
        
        XCTAssertEqual(includedCountry?.isoCode, "AT")
        
        let notIncludedCountry = dataSource.find("United States").first
        
        XCTAssertNil(notIncludedCountry)
    }
}
