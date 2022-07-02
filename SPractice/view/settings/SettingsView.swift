//
//  SettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import SwiftUI

struct SettingsItemView: View {
    @ObservedObject private var item: SettingsItem
    private var range: Range<Int>
    
    init(for item: SettingsItem, in range: Range<Int>) {
        self.item = item
        self.range = range
    }
    
    var body: some View {
        HStack {
            if item.isTabata {
                IntensityTypeImage(type: item.type == .tabata_activity ? .activity : .rest)
            }
            Text("\(item.type.rawValue)")
            Spacer()
            Picker("\(item.type.rawValue) duration", selection: $item.value) {
                ForEach(range, id: \.self) {
                    Text("\($0)")
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
        }
    }
}

struct SettingsView: View {
    
    private let settings = SettingsManager.shared.getSettings()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(SettingsItem.SettingsType.tabata_interval_sequence, id: \.self) { type in
                        SettingsItemView(for: settings.getItem(with: type), in: 0..<61)
                    }
                } header: {
                    Text("Tabata intervals")
                } footer: {
                    Text("These intervals are set in seconds and compose one full tabata cycle")
                }
                
                Section {
                    SettingsItemView(for: settings.getItem(with: .tabata_repetitions), in: 1..<17)
                } header: {
                    Text("Tabata exercise")
                } footer: {
                    Text("Number of activity+rest sequences during one tabata exercise")
                }
                
                Section {
                    SettingsItemView(for: settings.getItem(with: .general_rest), in: 0..<61)
                } header: {
                    Text("Rest")
                } footer: {
                    Text("You can use rest intervals to take a deep breath and prepare for the next exercise. Take your time!")
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        settings.restoreDefaults()
                        settings.save()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        settings.save()
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
