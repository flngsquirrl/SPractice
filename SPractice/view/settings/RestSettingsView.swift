//
//  RestSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct RestSettingsView: View {

    @ObservedObject private var nameItem = SettingsManager.restNameItem
    @ObservedObject private var durationItem = SettingsManager.restDurationItem

    let range = Array(stride(from: 10, through: 60, by: 10))

    var body: some View {
        Section {
            TextField("Exercise name", text: $nameItem.value)
                .disableAutocorrection(true)
                .onChange(of: nameItem.value) { _ in
                    SettingsManager.saveSettings()
                }
        } footer: {
            HStack {
                Text("Name of the exercise in practice")
            }
        }

        Section {
            HStack {
                Text("Duration")
                Spacer()
                DurationSecondsControl(seconds: $durationItem.value, range: range)
                    .onChange(of: durationItem.value) { _ in
                        SettingsManager.saveSettings()
                    }
            }
        } footer: {
            Text("You can use rest intervals to take a deep breath and prepare for the next exercise")
        }

        ResetToDefaultsButton(subgroup: .rest)
    }
}

struct PauseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                RestSettingsView()
            }
        }
    }
}
