//
//  CountryTests.swift
//  Planet
//
//  Created by Mikael Konutgan on 1/21/17.
//  Copyright © 2017 kWallet GmbH. All rights reserved.
//

import XCTest
@testable import Planet

class CountryTests: XCTestCase {
    func testAustriaInGerman() {
        let locale = Locale(identifier: "de_AT")
        let country = Country.find(isoCode: "AT", locale: locale)
        
        XCTAssertEqual(country?.name, "Österreich")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }
    
    func testAustriaInTurkish() {
        let locale = Locale(identifier: "tr_TR")
        let country = Country.find(isoCode: "AT", locale: locale)
        
        XCTAssertEqual(country?.name, "Avusturya")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }

    func testAustriaInNonRegionalGerman() {
        let locale = Locale(identifier: "de")
        let country = Country.find(isoCode: "AT", locale: locale)

        XCTAssertEqual(country?.name, "Österreich")
        XCTAssertEqual(country?.isoCode, "AT")
        XCTAssertEqual(country?.callingCode, "+43")
    }

}
