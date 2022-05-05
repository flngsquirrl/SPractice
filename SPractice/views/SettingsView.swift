//
//  SettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.05.22.
//

import SwiftUI

struct SettingsItemView: View {
    @ObservedObject var settings: Settings
    @State private var item: SettingsItem
    
    init(for item: SettingsItem, of settings: Settings) {
        self.item = item
        self.settings = settings
    }
    
    var body: some View {
        HStack {
            Text("\(item.type.rawValue) \(item.value)")
            Spacer()
            Picker("\(item.type.rawValue) duration", selection: $item.value) {
                ForEach(0..<60) {
                    Text("\($0)")
                }
            }
            .onChange(of: item.value) { _ in
                let updatedItem = item
                if let index = settings.items.firstIndex(of: item) {
                    settings.items[index] = updatedItem
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
        }
    }
}

struct SettingsView: View {
    @StateObject private var settings = Settings()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
//                Section {
//                    ForEach(SettingsItemType.tabata_interval_sequence, id: \.self) { type in
//                        SettingsItemView(for: settings.getItem(withType: type)!, of: settings)
//                    }
//                    SettingsItemView(for: settings.getItem(withType: .tabata_cycles)!, of: settings)
//                } header: {
//                    Text("Tabata")
//                } footer: {
//                    Text("Adjust the settings the way that suit your needs")
//                }
                
                Section {
                    SettingsItemView(for: settings.getItem(withType: .general_rest)!, of: settings)
                } header: {
                    Text("Rest")
                } footer: {
                    Text("You can use a rest interval to take a deep breath and prepare for the next exercise")
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                HStack {
                    Button("Restore defaults") {
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
