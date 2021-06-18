# ADAssertLayout

[![Version](https://img.shields.io/cocoapods/v/ADAssertLayout.svg?style=flat)](https://cocoapods.org/pods/ADAssertLayout)
[![License](https://img.shields.io/cocoapods/l/ADAssertLayout.svg?style=flat)](https://cocoapods.org/pods/ADAssertLayout)
[![Platform](https://img.shields.io/cocoapods/p/ADAssertLayout.svg?style=flat)](https://cocoapods.org/pods/ADAssertLayout)
![](https://github.com/faberNovel/ADAssertLayout/workflows/CI/badge.svg)

ADAssertLayout is a set of helpers to make layout assertions on `UIView`. The project is a Swift port of LinkedIn library [LayoutTest-iOS](https://github.com/linkedin/LayoutTest-iOS).

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Communication](#communication)
- [Credits](#credits)
- [License](#license)

## Features

- [x] Assert a view is within the bounds of its superview
- [x] Assert two siblings views are not overlaping
- [x] Assert a view has no ambiguous layout
- [x] Assert a view is before / after / above / below another view
- [x] Assert a view is aligned with another view

## Requirements

- iOS 9.0+
- Swift 5.1

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate ADAssertLayout into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'ADAssertLayout'
end
```

Then, run the following command:

```bash
$ pod install
```

## Communication

- If you **need help**, use [Twitter](https://twitter.com/FabernovelTech).
- If you'd like to **ask a general question**, use [Twitter](https://www.fabernovel.com/).
- If you'd like to **apply for a job**, visit [https://careers.fabernovel.com/](https://careers.fabernovel.com/).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Credits

ADAssertLayout is owned and maintained by [Fabernovel](https://www.fabernovel.com/). You can follow us on Twitter at [@Fabernovel](https://twitter.com/FabernovelTech).

## License

ADAssertLayout is released under the MIT license. [See LICENSE](LICENSE) for details.
