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
    
    var body: some View {
        Section {
            Toggle("Auto-finish", isOn: $flowAutoFinishItem.value.animation())
                .tint(.customAccentColor)
                .onChange(of: flowAutoFinishItem.value) { _ in
                    SettingsManager.saveSettings()
                }
        } header: {
            Text("Practice")
        } footer: {
            VStack {
                if flowAutoFinishItem.value {
                    Text("Flow exercises will be finished automatically")
                } else {
                    Text("Flow exercises will be finished when you move to another exercise or finish the practice")
                }
            }
        }
        
        if flowAutoFinishItem.value {
            Section {
                DurationControl(minutes: $flowAutoFinishAfterTimeItem.value.minutes, seconds: $flowAutoFinishAfterTimeItem.value.seconds) {
                    Text("After")
                    Spacer()
                }
                .onChange(of: flowAutoFinishAfterTimeItem.value) { _ in
                    SettingsManager.saveSettings()
                }
            } footer: {
                Text("You can still finish earlier moving to another exercise or finishing the practice")
            }
        }
        
        ResetToDefaultsButton(subgroup: .flow)
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
