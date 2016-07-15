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
        let bundle = NSBundle.planetBundle()
        
        return UIImage(named: imageName, inBundle: bundle, compatibleWithTraitCollection: nil)
    }
}
