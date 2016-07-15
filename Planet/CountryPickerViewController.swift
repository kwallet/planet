//
//  CountryPickerViewController.swift
//  Planet
//
//  Created by Mikael Konutgan on 08/07/16.
//  Copyright © 2016 kWallet GmbH. All rights reserved.
//

import UIKit

public class CountryPickerViewController: UITableViewController {
    weak public var delegate: CountryPickerViewControllerDelegate?
    
    public var currentCountry: Country? {
        return countryDataSource.currentCountry
    }
    
    public var showsCallingCodes = true
    
    public var showsCancelButton = true
    
    private var countryDataSource = CountryDataSource()
    
    private var searchResults: [Country]?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func findCountry(indexPath: NSIndexPath) -> Country {
        if let searchResults = searchResults {
            return searchResults[indexPath.row]
        } else {
            return countryDataSource.find(indexPath)
        }
    }
    
    private dynamic func cancelButtonTapped(sender: UIBarButtonItem) {
        delegate?.countryPickerViewControllerDidCancel(self)
    }
    
    private func tableFooterView() -> UIView {
        let tableFooterView = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 44.0))
        tableFooterView.text = NSLocalizedString("Icons by emojione.com", comment: "Icons by emojione.com")
        tableFooterView.textAlignment = .Center
        tableFooterView.textColor = UIColor(white: 0.500, alpha: 1.0)
        tableFooterView.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        
        return tableFooterView
    }
}

// MARK: UIViewController

public extension CountryPickerViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if showsCancelButton {
            let action = #selector(cancelButtonTapped)
            let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: action)
            navigationItem.leftBarButtonItem = leftBarButtonItem
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        tableView.tableFooterView = tableFooterView()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

public extension CountryPickerViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let _ = searchResults {
            return 1
        } else {
            return countryDataSource.sectionCount()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchResults = searchResults {
            return searchResults.count
        } else {
            return countryDataSource.count(section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let style: UITableViewCellStyle = showsCallingCodes ? .Subtitle : .Default
        let identifier = showsCallingCodes ? "SubtitleCell" : "DefaultCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)
            ?? UITableViewCell(style: style, reuseIdentifier: identifier)
        
        let country = findCountry(indexPath)
        
        cell.imageView?.image = country.image
        cell.textLabel?.text = country.name
        
        if showsCallingCodes {
            cell.detailTextLabel?.text = country.callingCode
        }
        
        cell.textLabel?.textColor = UIColor(white: 0.250, alpha: 1.0)
        cell.detailTextLabel?.textColor = UIColor(white: 0.500, alpha: 1.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.countryPickerViewController(self, didSelectCountry: findCountry(indexPath))
    }
    
    
}

// MARK: UISearchResultsUpdating

extension CountryPickerViewController: UISearchResultsUpdating {
    public func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let text = searchController.searchBar.text where !text.isEmpty {
            searchResults = countryDataSource.find(text)
        } else {
            searchResults = nil
        }
        
        tableView.reloadData()
    }
}
