<!-- Copy badges from SPI -->
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-settings-service%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simonnickel/snap-settings-service)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-settings-service%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simonnickel/snap-settings-service) 

> This package is part of the [SNAP](https://github.com/simonnickel/snap) suite.

# SnapSettingsService

A single interface to handle different types of settings. It stores a `Codable` type for a `String` key, either locally (UserDefaults), synced (NSUbiquitousKeyValueStore) or in a custom store.

This package provides the `SettingsService` class, `SettingsStore` protocol and helper to define, save and read settings.

[![Documentation][documentation badge]][documentation] 

[documentation]: https://swiftpackageindex.com/simonnickel/snap-settings-service/main/documentation/snapsettingsservice
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue


## Setup

To support settings stored in iCloud (`NSUbiquitousKeyValueStore`) you have to add the `iCloud` Capability to the target and enable the `Key-value storage` checkbox.


## Demo

The [demo project](/SnapSettingsServiceDemo) shows an example usage of the SettingsService with settings in different scopes.

<img src="/screenshot.png" height="400">


## How to use

Define your settings:
```
extension SettingsService.SettingDefinition {
	static let exampleNumber = SettingsService.Setting<Int>("ExampleNumber", in: .defaults, default: 1)
}
```

Read and write the settings:
```
let settings = SettingsService()
settings.set(.exampleNumber, to: 2)
let number = settings.get(.exampleNumber)
```

Use the binding, when you need it to update on changes:
```
struct MyView: View {
	let observableValue: SettingsService.Value<Int> = settings.value(.exampleNumber)
	var body: some View {
		Text("\(observableValue.value)")
		SomeView(binding: observableValue.binding)
	}
}
```


## Scope

The `SettingsService` can be configured with a `SettingsStore` object for a `Scope`: .defaults, .ubiquitous, .custom(id:)
```
SettingsService.init(defaults: UserDefaults? = .standard, ubiquitous: NSUbiquitousKeyValueStore? = .default, storesForCustomScopes: [Scope : SettingsStore] = [:])
```


### .defaults

Stored locally in `UserDefaults`.

// TODO: How to handle privacy requirements.


### .ubiquitous

Stored in iCloud using `NSUbiquitousKeyValueStore`. 

If user is not logged in, the value is stored locally and a warning is logged. 

> To use NSUbiquitousKeyValueStore, you must distribute your app through the App Store or Mac App Store, and you must request the com.apple.developer.ubiquity-kvstore-identifier entitlement in your Xcode project.
[NSUbiquitousKeyValueStore Documentation](https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore#)

(see [Setup](#Setup))


### .custom(id:)

You can provide one or multiple custom stores that implement `SettingsStore`.

If there is no store registered for the scope, a warning is logged. 



## SettingsStore

UserDefaults and NSUbiquitousKeyValueStore are extended to conform to SettingsStore.


### Custom

You can create a custom store by implementing `SettingsStore`. 

```
public protocol SettingsStore {
	func get<T>(_ key: SettingsService.Setting<T>) -> Data?
	func set<T>(_ key: SettingsService.Setting<T>, to data: Data?)
}
```


## Access Setting


### Get & Set

```
let settings = SettingsService()
settings.set(.exampleNumber, to: 2)
let number = settings.get(.exampleNumber)
```

### Observable Value

```
struct MyView: View {
	let observableValue: SettingsService.Value<Int> = settings.value(.exampleNumber)
	var body: some View {
		Text("\(observableValue.value)")
		SomeView(binding: observableValue.binding)
	}
}
```

### Publisher

The `SettingsService` provides a Combine publisher to receive updated values. If the setting is stored in the `.ubiquitous` scope, the publisher is updated on remote changes (`NSUbiquitousKeyValueStore.didChangeExternallyNotification`). 



## Environment

The `SettingsService` can be used by the provided `EnvironmentKey`.

Inject into the `@Environment`: 
```
@Environment(\.serviceSettings) private var settings
```

Access from `@Environment`:
```
View().environment(\.serviceSettings, settings)
```


## TODO

// TODO: App Groups? Access in Widget?
// TODO: Handle iCloud not available. It does store locally and logs a warning, but should do something?
