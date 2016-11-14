# Planet

A country picker view controller for iOS.

<img src="https://s3.amazonaws.com/f.cl.ly/items/1z3M1J061d013C1i0H0f/planet.png" width="200">

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `Planet` by adding it to your `Podfile`:

```ruby
platform :ios, '10.0'
use_frameworks!
pod 'Planet'
```

#### Manually
1. Download and drop `/Planet` folder in your project.  
2. Congratulations!

## Example

First, import the library:
```swift
 import Planet
```

Then, create the view controller:

```swift
let viewController = CountryPickerViewController()
viewController.delegate = self
```

after you present it and the user selects a country you will get a callback with the country name, ISO code, and calling code.

```swift
func countryPickerViewController(countryPickerViewController: CountryPickerViewController, didSelectCountry country: Country)
```

## Customization

- You can hide the calling codes by toggling `showsCallingCodes`.
- And you can remove the cancel button, for example if you want to present the view controller by pushing it or in a popover by setting `showsCancelButton` to `false`.
- You can show a custom list of countries instead of all countries by supplying a list of ISO codes in the `countryCodes` property. See the comment in the example project

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
