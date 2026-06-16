@../snap/agents/AGENTS-shared.md

# SnapSettingsService

`SettingsService` manages app settings across multiple storage scopes. Values are JSON-encoded and stored as `Data` via `SettingsStore` backends; `UserDefaults` and `NSUbiquitousKeyValueStore` conform out of the box.

## Defining settings

Add settings as `static let` properties on extensions of `SettingsService.SettingDefinition`. Do not add them to `SettingsService`. This makes them accessible via dot-shorthand: `settings.get(.myKey)`.

`Setting<T>` inherits from `SettingDefinition` but is intentionally not marked `public`. Consumers reference settings through the static properties, never by naming `Setting<T>` directly.
