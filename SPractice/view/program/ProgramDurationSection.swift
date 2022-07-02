//
//  ProgramDurationSection.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import SwiftUI

struct ProgramDurationSection: View {
    var template: ProgramTemplate
    
    var body: some View {
        Section {
            HStack {
                Text("Duration")
                Spacer()
                ProgramDurationView(for: template, mode: .extended)
                    .foregroundColor(.secondary)
            }
        } header: {
            Text("Summary")
        } footer: {
            LayoutUtils.durationSectionFooter
        }
    }
}

struct ProgramDurationSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramDurationSection(template: ProgramTemplate.personal)
        }
    }
}
