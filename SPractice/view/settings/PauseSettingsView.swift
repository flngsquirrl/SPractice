//
//  PauseSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct PauseSettingsView: View {
    
    @ObservedObject private var nameItem = SettingsManager.pauseNameItem
    @ObservedObject private var durationItem = SettingsManager.pauseDurationItem
    
    @State private var areDefaultsRestored = false
    
    let range = Array(stride(from: 10, through: 60, by: 10))
    
    var body: some View {
        Section {
            TextField("Exercise name", text: $nameItem.value)
                .disableAutocorrection(true)
        } footer: {
            HStack {
                Text("Name used in program sequences and practices")
            }
        }
        
        Section {
            HStack {
                Text("Duration")
                Spacer()
                DurationSecondsControl(seconds: $durationItem.value, range: range)
            }
        } footer: {
            Text("You can use pauses to take a deep breath and prepare for the next exercise. Take your time!")
        }
        
        RestoreDefaultsButton(subgroup: .pause, areDefaultsRestored: $areDefaultsRestored)
            .id(UUID())
    }
}

struct PauseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PauseSettingsView()
            }
        }
    }
}
