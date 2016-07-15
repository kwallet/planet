//
//  NSBundle+Planet.swift
//  Planet
//
//  Created by Mikael Konutgan on 15/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import Foundation

extension NSBundle {
    class func planetBundle() -> NSBundle {
        return NSBundle(forClass: CountryPickerViewController.self)
    }
}
