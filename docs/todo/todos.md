# TODO

Outstanding work on the package.

## TODO-1: App Groups

Decide whether settings need App Group support, for example for access from a widget.

## TODO-2: Handle iCloud not available

When iCloud is not available, `NSUbiquitousKeyValueStore` stores `.ubiquitous` settings locally, without involving `SettingsService`. Decide whether the service should handle this case.

## TODO-3: Compare with PersistentKeyValueKit

Compare with [PersistentKeyValueKit](https://github.com/kylehughes/PersistentKeyValueKit).

## TODO-4: Compare with Defaults

Compare with [Defaults](https://github.com/sindresorhus/Defaults).

## TODO-5: Privacy requirements

Decide how to handle the privacy requirements of storing settings in `UserDefaults`.
