//
//  CountryPickerViewControllerDelegate.swift
//  Planet
//
//  Created by Mikael Konutgan on 15/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import Foundation

public protocol CountryPickerViewControllerDelegate: NSObjectProtocol {
    func countryPickerViewControllerDidCancel(countryPickerViewController: CountryPickerViewController)
    func countryPickerViewController(countryPickerViewController: CountryPickerViewController, didSelectCountry country: Country)
}
