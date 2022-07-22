//
//  ProgramDurationSection.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import SwiftUI

struct ProgramDurationSection<T>: View where T: Program {
    var program: T
    
    @ObservedObject var settings = SettingsManager.settings
    
    var body: some View {
        Section {
            HStack {
                Text("Duration")
                InfoButton()
                Spacer()
                ProgramDurationView(for: program, mode: .extended)
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("Summary")
        }
    }
}

struct ProgramDurationSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramDurationSection(program: ProgramTemplate.personal)
        }
    }
}
