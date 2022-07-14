//
//  FlowSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct FlowSettingsView: View {
    
    @ObservedObject private var flowAutoFinishItem = SettingsManager.flowAutoFinishItem
    @ObservedObject private var flowAutoFinishAfterTimeItem = SettingsManager.flowAutoFinishAfterTimeItem
    
    @State private var areDefaultsRestored = false
    
    var body: some View {
        Section {
            Toggle("Auto-finish", isOn: $flowAutoFinishItem.value.animation())
                .tint(.customAccentColor)
            
            if flowAutoFinishItem.value {
                DurationControl(minutes: $flowAutoFinishAfterTimeItem.value.minutes, seconds: $flowAutoFinishAfterTimeItem.value.seconds) {
                    Text("After")
                    Spacer()
                }
            }
        } header: {
            Text("In practice")
        } footer: {
                if flowAutoFinishItem.value {
                Text("Even with auto-finish toggle on, you can finish a flow exercise earlier if you want to")
            }
        }
        
        RestoreDefaultsButton(subgroup: .flow, areDefaultsRestored: $areDefaultsRestored)
            .id(UUID())
    }
}

struct FlowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                FlowSettingsView()
            }
        }
    }
}
