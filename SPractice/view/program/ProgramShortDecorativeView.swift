//
//  ProgramShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.07.22.
//

import SwiftUI

struct ProgramShortDecorativeView: View {
    var template: ProgramTemplate
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(template.name)")
                .fontWeight(.semibold)
            Group {
                Text("\(template.templateExercises.count) ") +
                Text(template.templateExercises.count == 1 ? "exercise" : "exercises")
            }
            .foregroundColor(.secondary)
        }
        Spacer()
        ProgramDurationView(for: template)
            .foregroundColor(.secondary)
    }
}

struct ProgramShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramShortDecorativeView(template: ProgramTemplate.personal)
    }
}
