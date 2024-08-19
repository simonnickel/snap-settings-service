//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapSettingsService

struct SettingsList: View {
	
	@Environment(\.serviceSettings) private var settings
	
	var body: some View {
		List {
			
			Section {
				Toggle(isOn: settings.binding(.settingsLocal), label: {
					ListRowLabel(subtitle: "settings.binding()", subsubtitle: "update on load")
				})
				
				ToggleWithValue(settingsValue: settings.value(.settingsLocal))
				
				ButtonWithValue(settingsValue: settings.value(.settingsLocal))
			} header: {
				TitleLabel(title: ".defaults")
			}
				
			Section {
				Toggle(isOn: settings.binding(.settingsSynced), label: {
					// TODO macOS: Checkbox does not get enabled on click.
					ListRowLabel(subtitle: "settings.binding()", subsubtitle: "update on load")
				})
				
				ToggleWithValue(settingsValue: settings.value(.settingsSynced))
				
				LabelWithValue(settingsValue: settings.value(.settingsSynced))
			} header: {
				TitleLabel(title: ".ubiquitous")
			} footer: {
				Text("Stored on device and in iCloud")
			}
			
			Section {
				Toggle(isOn: settings.binding(.settingsCustom), label: {
					ListRowLabel(title: ".custom", subtitle: "Example temp storage")
				})
				
				Toggle(isOn: settings.binding(.settingsStoreNotAvailable), label: {
					ListRowLabel(title: "Store not available", subtitle: "Logs warning")
				})

			}
			
		}
	}
	
	
	// MARK: - TitleLabel
	
	struct TitleLabel: View {
		let title: String
		
		var body: some View {
			Text(title)
				.textCase(.none)
				.font(.headline)
				.foregroundColor(.accentColor)
		}
	}
	
	// MARK: - ListRowLabel
	
	struct ListRowLabel: View {
		internal init(title: String? = nil, subtitle: String? = nil, subsubtitle: String? = nil) {
			self.title = title
			self.subtitle = subtitle
			self.subsubtitle = subsubtitle
		}
		
		let title: String?
		let subtitle: String?
		let subsubtitle: String?
		
		var body: some View {
			VStack(alignment: .leading) {
				if let title {
					TitleLabel(title: title)
				}
				if let subtitle {
					Text(subtitle)
						.font(.subheadline)
				}
				if let subsubtitle {
					Text(subsubtitle)
						.font(.subheadline)
				}
			}
		}
	}
	
	
	// MARK: - ToggleWithValue
	
	struct ToggleWithValue: View {
		
		let settingsValue: SettingsService.Value<Bool>
		
		var body: some View {
			Toggle(isOn: settingsValue.binding, label: {
				ListRowLabel(subtitle: "settings.value().binding", subsubtitle: "update on change")
			})
		}
		
	}
	
	
	// MARK: - LabelWithValue
	
	struct LabelWithValue: View {
		
		let settingsValue: SettingsService.Value<Bool>
		
		var body: some View {
			HStack {
				ListRowLabel(subtitle: "settings.value().value", subsubtitle: "update on change")
				Spacer()
				Text(settingsValue.value ? "true" : "false")
			}
		}
		
	}
	
	
	// MARK: - ButtonWithValue
	
	struct ButtonWithValue: View {
		
		let settingsValue: SettingsService.Value<Bool>
		
		var body: some View {
			Button {
				settingsValue.set(!settingsValue.value)
				// Alternative:
				// settingsValue.binding.wrappedValue.toggle()
			} label: {
				Text("Toggle is: \(settingsValue.value ? "on" : "off")")
			}
		}
		
	}
}


// MARK: - Previews

#Preview {
	SettingsList()
}
