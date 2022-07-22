//
//  ProgramShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.07.22.
//

import SwiftUI

struct ProgramShortDecorativeView: View {
    private var program: ProgramTemplate
    private var isAccented: Bool
    private var accentColor: Color
    
    @ObservedObject var settings = SettingsManager.settings
    
    init(for program: ProgramTemplate, isAccented: Bool = false, accentColor: Color = .customAccentColor) {
        self.program = program
        self.isAccented = isAccented
        self.accentColor = accentColor
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if isAccented {
                    Text("\(program.name)")
                        .fontWeight(.semibold)
                        .foregroundColor(accentColor)
                } else {
                    Text("\(program.name)")
                        .fontWeight(.semibold)
                }
                Group {
                    Text("\(program.templateExercises.count) ") +
                    Text(program.templateExercises.count == 1 ? "exercise" : "exercises")
                }
                .foregroundColor(.secondary)
            }
            Spacer()
            ProgramDurationView(for: program)
                .foregroundColor(.secondary)
        }
    }
}

struct ProgramShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramShortDecorativeView(for: ProgramTemplate.personal)
        }
    }
}
