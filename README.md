# SnapSettingsService

This package provides the `SettingsService` class, `SettingsStore` protocol and helper to save settings. They can be stored locally (UserDefaults), synced (NSUbiquitousKeyValueStore) or in a custom store. 

> This package is part of the [SNAP](https://github.com/simonnickel/snap-abstract) suite.


## How to use

Define your settings:
```
extension SettingsService.SettingDefinition {
	static let exampleNumber = SettingsService.Setting<Int>("ExampleNumber", in: .defaults, default: 1)
}
```

Simply use your settings:
```
let settings = SettingsService()
settings.set(.exampleNumber, to: 2)
let number = settings.get(.exampleNumber)
```

When you need it to update on changes:
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

// TODO: ... 
 - Add Documentation
 - Add Tests

// TODO: App Groups? Access in Widget?
// TODO: Handle iCloud not available. It does store locally and logs a warning, but should do something?
