//
//  ViewController.swift
//  PlanetExample
//
//  Created by Mikael Konutgan on 15/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import UIKit
import Planet

class ViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let viewController = CountryPickerViewController()
        viewController.delegate = self
        
        print("The current country is \(viewController.currentCountry)")

        // uncomment the next line to filter for iso codes
//        viewController.filteredISOCodes = ["DE", "US", "IN"]

        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
}

extension ViewController: CountryPickerViewControllerDelegate {
    func countryPickerViewControllerDidCancel(_ countryPickerViewController: CountryPickerViewController) {
        print("countryPickerViewControllerDidCancel: \(countryPickerViewController)")
        
        dismiss(animated: true, completion: nil)
    }
    
    func countryPickerViewController(_ countryPickerViewController: CountryPickerViewController, didSelectCountry country: Country) {
        print("countryPickerViewController: \(countryPickerViewController) didSelectCountry: \(country)")
        
        dismiss(animated: true, completion: nil)
    }
}
