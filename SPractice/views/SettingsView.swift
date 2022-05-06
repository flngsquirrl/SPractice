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
            if (isWithToggle(type: item.type)) {
                Toggle("Is enabled?", isOn: $item.enabled).labelsHidden()
                    .disabled(isDisabled(type: item.type))
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

extension SettingsItemView {
    static let withToggleEnabled: [SettingsItem.SettingsType] = [.tabata_warmup, .tabata_cooldown]
    static let withToggle: [SettingsItem.SettingsType] = [.tabata_warmup, .tabata_activity, .tabata_rest, .tabata_cooldown]
    
    func isDisabled(type: SettingsItem.SettingsType) -> Bool {
        !SettingsItemView.withToggleEnabled.contains(item.type)
    }
    
    func isWithToggle(type: SettingsItem.SettingsType) -> Bool {
        SettingsItemView.withToggle.contains(item.type)
    }
}

struct SettingsView: View {
    private var settings = Settings()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(SettingsItem.SettingsType.tabata_interval_sequence, id: \.self) { type in
                        SettingsItemView(for: settings.getItem(with: type), in: 0..<60)
                    }
                } header: {
                    Text("Tabata intervals")
                } footer: {
                    Text("These intervals compose one full Tabata cycle")
                }
                
                Section {
                    SettingsItemView(for: settings.getItem(with: .tabata_repetitions), in: 1..<17)
                } header: {
                    Text("Tabata exercise")
                } footer: {
                    Text("Number of activity+rest sequences to run during one Tabata exercise")
                }
                
                Section {
                    SettingsItemView(for: settings.getItem(with: .general_rest), in: 0..<60)
                } header: {
                    Text("Rest")
                } footer: {
                    Text("You can use rest intervals to take a deep breath and prepare for the next exercise")
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                HStack {
                    Button("Reset") {
                        settings.restoreDefaults()
                        settings.save()
                    }
                    
                    Button("Save") {
                        settings.save()
                        dismiss()
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
