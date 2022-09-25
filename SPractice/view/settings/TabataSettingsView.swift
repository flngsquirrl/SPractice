//
//  TabataSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct TabataSettingsView: View {

    @EnvironmentObject var manager: SettingsManager

    var body: some View {
        Section {
            TabataItemIntervalView(value: $manager.tabataWarmUpDurationItem.value, name: "warm-up", intensity: .rest)
            TabataItemIntervalView(value: $manager.tabataActivityDurationItem.value, name: "activity", intensity: .activity)
            TabataItemIntervalView(value: $manager.tabataRestDurationItem.value, name: "rest", intensity: .rest)
            TabataItemIntervalView(value: $manager.tabataCoolDownDurationItem.value, name: "cool-down", intensity: .rest)
        } header: {
            Text("Tasks")
        } footer: {
            Text("These tasks compose one tabata exercise")
        }
        .rowLeadingAligned()

        Section {
            HStack {
                Text("Number of cycles")
                Spacer()
                NumberSelectionControl(number: $manager.tabataCyclesItem.value)
            }
        } footer: {
            Text("Repeating \"activity + rest\" sequences in one tabata exercise")
        }

        ResetToDefaultsButton(subgroup: .tabata)
    }
}

struct TabataItemIntervalView: View {

    @Binding var value: Int

    var name: String
    var intensity: Intensity

    static let range = Array(stride(from: 10, through: 60, by: 10))

    var body: some View {
        HStack {
            IntensityImage(intensity: intensity)
            Text(name)
            Spacer()
            DurationSecondsControl(seconds: $value, range: Self.range)
        }
    }
}

struct TabataSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                TabataSettingsView()
            }
        }
    }
}
