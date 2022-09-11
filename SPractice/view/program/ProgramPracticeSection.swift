//
//  ProgramPracticeSection.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.09.22.
//

import SwiftUI

struct ProgramPracticeSection: View {

    var program: ProgramTemplate

    @State private var showPracticeView = false
    @State private var showPracticeSettings = false

    var body: some View {
        let isPracticeDisabled = isPracticeDisabled()
        Section {
            Button {
                showPracticeView = true
            } label: {
                let image = getRunImage(isPracticeDisabled: isPracticeDisabled)
                Label("Run", systemImage: image)
                    .foregroundColor(isPracticeDisabled ? .secondary : nil)
            }
            .disabled(isPracticeDisabled)
            .fullScreenCover(isPresented: $showPracticeView) {
                PracticeView(for: program)
            }

            Button {
                showPracticeSettings = true
            } label: {
                Label("Configure", systemImage: "slider.horizontal.3")
            }
            .sheet(isPresented: $showPracticeSettings) {
                PracticeSettingsView(for: program)
            }
        } header: {
            Text("Practice")
        } footer: {
            if isPracticeDisabled {
                Text("Set type and duration for all the exercises to run the practice")
            }
        }
        .rowLeadingAligned()
    }

    func getRunImage(isPracticeDisabled: Bool) -> String {
        isPracticeDisabled ? "play.rectangle" : "play.rectangle.fill"
    }

    func isPracticeDisabled() -> Bool {
        !ValidationService.isValidToPractice(template: program)
    }
}

struct ProgramPracticeSection_Previews: PreviewProvider {
    static var previews: some View {
        ProgramPracticeSection(program: .simpleYoga)
    }
}
