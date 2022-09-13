//
//  ExampleHelpContent.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

enum HelpPage {
    case example
    case execiseType
    case exerciseDuration
    case exerciseIntensity
    case programDuration
}

struct HelpPageContent: View {

    var helpPage: HelpPage

    private static var helpPages: [HelpPage: AnyView] = [
        .example: AnyView(ExamplesHelp()),
        .execiseType: AnyView(ExerciseTypeHelp()),
        .exerciseDuration: AnyView(ExerciseDurationHelp()),
        .exerciseIntensity: AnyView(ExerciseIntensityHelp()),
        .programDuration: AnyView(ProgramDurationHelp())]

    var body: some View {
        help
            .fixedSize(horizontal: false, vertical: true)
            .font(.body)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity)
            .wrapped()
            .padding()
    }

    var help: AnyView {
        if let helpContent = Self.helpPages[helpPage] {
            return helpContent
        }
        fatalError("No help content for \(helpPage)")
    }
}

struct ExampleHelpContent_Previews: PreviewProvider {
    static var previews: some View {
        HelpPageContent(helpPage: .example)
    }
}
