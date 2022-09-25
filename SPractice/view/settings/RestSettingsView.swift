//
//  RestSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct RestSettingsView: View {

    @EnvironmentObject var manager: SettingsManager

    let range = Array(stride(from: 10, through: 60, by: 10))

    var body: some View {
        Section {
            TextField("Exercise name", text: $manager.restNameItem.value)
                .disableAutocorrection(true)
        } footer: {
            HStack {
                Text("Name of the exercise in practice")
            }
        }

        Section {
            HStack {
                Text("Duration")
                Spacer()
                DurationSecondsControl(seconds: $manager.restDurationItem.value, range: range)
            }
        } footer: {
            Text("You can use rest intervals to prepare for the next exercise")
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
