//
//  TabataSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct TabataSettingsView: View {
    
    @ObservedObject var tabataWarmUpDurationItem = SettingsManager.shared.tabataWarmUpDurationItem
    @ObservedObject var tabataActivityDurationItem = SettingsManager.shared.tabataActivityDurationItem
    @ObservedObject var tabataRestDurationItem = SettingsManager.shared.tabataRestDurationItem
    @ObservedObject var tabataCoolDownDurationItem = SettingsManager.shared.tabataCoolDownDurationItem
    @ObservedObject var tabataCyclesItem = SettingsManager.shared.tabataCyclesItem
    
    var body: some View {
        Section {
            TabataItemIntervalView(value: $tabataWarmUpDurationItem.value, name: "warm-up", intensity: .rest)
            TabataItemIntervalView(value: $tabataActivityDurationItem.value, name: "activity", intensity: .activity)
            TabataItemIntervalView(value: $tabataRestDurationItem.value, name: "rest", intensity: .rest)
            TabataItemIntervalView(value: $tabataCoolDownDurationItem.value, name: "cool-down", intensity: .rest)
        } header: {
            Text("Tasks")
        } footer: {
            Text("These tasks compose one tabata exercise")
        }
        
        Section {
            HStack {
                Text("Number of cycles")
                Spacer()
                NumberSelectionControl(number: $tabataCyclesItem.value)
            }
        } header: {
            Text("Exercise")
        } footer: {
            Text("Repeating \"activity + rest\" sequences in one tabata exercise")
        }
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
        NavigationView {
            List {
                TabataSettingsView()
            }
        }
    }
}