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
                Text("\(program.name)")
                    .font(.headline)
                    .foregroundColor(isAccented ? accentColor : nil)

                Group {
                    Text("\(program.exercises.count) ") +
                    Text(program.exercises.count == 1 ? "exercise" : "exercises")
                }
                .foregroundColor(.secondary)
            }
        }
    }
}

struct ProgramShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramShortDecorativeView(for: .simpleWorkout)
            ProgramShortDecorativeView(for: .simpleYoga)
        }
        .listStyle(.insetGrouped)
    }
}
