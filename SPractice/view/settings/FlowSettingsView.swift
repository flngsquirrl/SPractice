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
            } footer: {
                Text("You can still finish earlier moving to another exercise or finishing the practice")
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
