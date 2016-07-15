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
    
    @IBAction func buttonTapped(sender: UIButton) {
        let viewController = CountryPickerViewController()
        viewController.delegate = self
        
        print("The current country is \(viewController.currentCountry)")
        
        let navigationController = UINavigationController(rootViewController: viewController)
        presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension ViewController: CountryPickerViewControllerDelegate {
    func countryPickerViewControllerDidCancel(countryPickerViewController: CountryPickerViewController) {
        print("countryPickerViewControllerDidCancel: \(countryPickerViewController)")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func countryPickerViewController(countryPickerViewController: CountryPickerViewController, didSelectCountry country: Country) {
        print("countryPickerViewController: \(countryPickerViewController) didSelectCountry: \(country)")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
