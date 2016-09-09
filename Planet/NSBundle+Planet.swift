//
//  NSBundle+Planet.swift
//  Planet
//
//  Created by Mikael Konutgan on 15/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import Foundation

extension Bundle {
    class func planetBundle() -> Bundle {
        return Bundle(for: CountryPickerViewController.self)
    }
}
