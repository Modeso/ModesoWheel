# ModesoWheel
by [Modeso](https://www.modeso.ch)

[![CocoaPods Compatible](https://img.shields.io/badge/Pod-compatible-4BC51D.svg
)](https://cocoapods.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-d3d3d3.svg)]()
[![Twitter](https://img.shields.io/badge/twitter-@modeso_ch-0B0032.svg?style=flat)](https://twitter.com/modeso_ch)


A framework based on [Modeso](https://www.modeso.ch)'s design for creating a wheel selection control. It can be used for any kind of options list. 

## Overview

<img src="ModesoWheelDemo/Media/Example.gif" width=180 height=400 />

## Contents

* [Getting Started](#gettingStarted)
  + [Requirements](#requirements)
  + [Installation](#installation)
* [Setup](#setup)
  + [Designable View](#designableview)
* [Usage](#usage)
  + [Configuration](#configuration)
  + [Modeso Wheel Delegate](#modesowheeldelegate)
* [Contribution](#contribution)
* [Let Us Know](#letUsKnow)
* [Credits](#credits)
* [License](#license)

<a name="gettingStarted"/>

## Getting Started

### Requirements 
- iOS 9+
- Swift 3.0+
- Xcode 8.0+

### Installation 
ModesoWheel is available through [CocoaPods](https://cocoapods.org). To install, add the following line to your Podfile.

```
pod ModesoWheel
```

Or if you opt from using cocoapods, you can add the source files manually to your project.

## Setup

ModesoWheel was designed to be used as a standalone UIView. 

<a name="designableview"/>

### Designable View 

- Add UIView inside your ViewController.
- Set it's Custom Class to ModesoWheel.
- Take an IBoutlet refrence for wheel view.
- Set up wheel view constraint to have a height constraint.
- Take an IBoutlet refrence for wheel view height constraint.

You can set the following values using StroyBoard properties or from code:
- inputTitle: string value that presents the title of data.
- defaultInputValue: default value to be displayed.
- background: cells background color.
- selectionIndicatorColor: background color for separator view.

## Usage

### Configuration

user Configure method to setup wheel component data:

```swift
func configure(withData data: [String], defaultValue: String)
```

<a name="modesowheeldelegate"/>

### Modeso Wheel Delegate

The protocol ```ModesoWheelDelegate``` has the following methods: 

```swift
func resizeWheel(_ view: ModesoWheel, to height: CGFloat)
```
This method is called when wheel view is expanding or dimissing.
Use this method to update wheel view height with the current height.

```swift
func wheelTapped(_ view: ModesoWheel)
```
This method called when tap on the wheel did become active.

```swift
func wheelDidSelectValue(_ view: ModesoWheel)
```
This method called when selected value changed.

## Contribution

You are welcome to fork and submit pull requests, report issues or request features.

<a name="letUsKnow"/>

## Let us know!

We will be really happy if you send us links to your projects which use our component. Just send an email to info@modeso.ch. 
And do let us know if you have any suggestions or questions. 

## Credits

ModesoWheel is owned and maintained by [Modeso](http://modeso.ch) Using our design. You can follow us on Twitter at [@modeso_ch](https://twitter.com/modeso_ch) for project updates and releases.

## License

ModesoWheel is released under the MIT license. See LICENSE for details.
