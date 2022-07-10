//
//  ProgramShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.07.22.
//

import SwiftUI

struct ProgramShortDecorativeView: View {
    var program: ProgramTemplate
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(program.name)")
                .fontWeight(.semibold)
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
        ProgramShortDecorativeView(program: ProgramTemplate.personal)
    }
}
