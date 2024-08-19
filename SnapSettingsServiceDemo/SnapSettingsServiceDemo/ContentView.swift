//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapCore
import SnapSettingsService

struct ContentView: View {
	
    var body: some View {
		NavigationStack {
			List {
				
				Section {
					NavigationLink {
						SettingsList()
					} label: {
						Text("Settings")
					}
				} footer: {
					Text("On remote change, log should show 0 publisher while on this screen.")
				}
				
			}
		}
    }
	
}

#Preview {
    ContentView()
}
