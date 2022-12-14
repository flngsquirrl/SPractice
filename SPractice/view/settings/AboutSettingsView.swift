//
//  AboutSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.08.22.
//

import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        Section {
            HStack {
                SquirrelInWheelIcon(lineWidth: 5)
                    .frame(width: 100, height: 100)

                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                    Group {
                        Text("Version ") + Text(version)
                    }
                    .foregroundColor(.secondary)

                    Spacer()
                    Text("crafted by @flngsquirrl")
                        .font(.caption)
                        .foregroundColor(.secondary)

                }
                .padding()
            }
        }
    }

    var name: String {
        readBundleProperty(key: "CFBundleName")
    }

    var version: String {
        readBundleProperty(key: "CFBundleShortVersionString")
    }

    func readBundleProperty(key: String) -> String {
        if let name = Bundle.main.object(forInfoDictionaryKey: key) {
            if let nameString = name as? String {
                return nameString
            }
        }
        return "unknown"
    }
}

struct AboutSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AboutSettingsView()
        }
    }
}
