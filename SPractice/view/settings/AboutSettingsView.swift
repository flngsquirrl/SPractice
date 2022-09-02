//
//  AboutSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.08.22.
//

import SwiftUI

struct AboutSettingsView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    SquirrelInWheelLogo()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
                .padding()

                HStack {
                    Text("Application")
                    Spacer()
                    Text(name)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Version")
                    Spacer()
                    Text(version)
                        .foregroundColor(.secondary)
                }
            } footer: {
                Text("Crafted by @flng.squirrl")
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
        AboutSettingsView()
    }
}
