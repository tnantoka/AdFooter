# AdFooter

[![Version](https://img.shields.io/cocoapods/v/AdFooter.svg?style=flat)](http://cocoapods.org/pods/AdFooter)
[![License](https://img.shields.io/cocoapods/l/AdFooter.svg?style=flat)](http://cocoapods.org/pods/AdFooter)
[![Platform](https://img.shields.io/cocoapods/p/AdFooter.svg?style=flat)](http://cocoapods.org/pods/AdFooter)


## Return to GitHub

https://github.com/tnantoka/adfooter

We previously moved to GitLab due to file size limitations, but have now returned to GitHub after removing the Frameworks directory, which resolved the size issue.

If you need to access previous versions, please refer to the GitLab repository:

https://gitlab.com/tnantoka/adfooter

## Usage

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let navController = UINavigationController(rootViewController: ViewController())

    AdFooter.shared.adMobApplicationId = "ADMOB_APPLICATION_ID"
    AdFooter.shared.adMobAdUnitId = "ADMOB_AD_UNIT_ID"
    window?.rootViewController = AdFooter.shared.wrap(navController)

    window?.makeKeyAndVisible()
    return true
}
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- AdMob's Ad unit ID

## Installation

AdFooter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AdFooter'
```

## Carthage

```swift
git "https://gitlab.com/tnantoka/adfooter"
```

## AddFooter on App Store

- https://gradientor.tnantoka.com/
- https://remaining.bornneet.com/

## Author

[tnantoka](https://twitter.com/tnantoka)

## Acknowledgement

https://github.com/chrisjp/CJPAdController

## License

AdFooter is available under the MIT license. See the LICENSE file for more info.
