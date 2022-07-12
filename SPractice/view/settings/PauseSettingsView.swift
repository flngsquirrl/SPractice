//
//  PauseSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct PauseSettingsView: View {
    
    @ObservedObject private var nameItem = SettingsManager.shared.pauseNameItem
    @ObservedObject private var durationItem = SettingsManager.shared.pauseDurationItem
    
    let range = Array(stride(from: 10, through: 60, by: 10))
    
    var body: some View {
        Section {
            TextField("Exercise name", text: $nameItem.value)
        } header: {
            Text("Exercise name")
        } footer: {
            Text("This name will be used in program sequences and during practices")
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
