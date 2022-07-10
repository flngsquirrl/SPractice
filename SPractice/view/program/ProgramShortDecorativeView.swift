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
    
    init(for program: ProgramTemplate, isAccented: Bool = false, accentColor: Color = .customAccentColor) {
        self.program = program
        self.isAccented = isAccented
        self.accentColor = accentColor
    }
    
    var body: some View {
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
                Text("\(program.exercises.count) ") +
                Text(program.exercises.count == 1 ? "exercise" : "exercises")
            }
            .foregroundColor(.secondary)
        }
        Spacer()
        ProgramDurationView(for: preparedProgram)
            .foregroundColor(.secondary)
    }
    
    var preparedProgram: PreparedProgram {
        PreparedProgram(from: program)
    }
}

struct ProgramShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramShortDecorativeView(for: ProgramTemplate.personal)
    }
}
