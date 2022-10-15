//
//  InfoPanel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.09.22.
//

import SwiftUI

struct InfoPanel: View {

    @EnvironmentObject var infoManager: InfoManager

    private static var infoPages: [InfoPage: AnyView] = [
        .example: AnyView(ExamplesInfo()),
        .execiseType: AnyView(ExerciseTypeInfo()),
        .exerciseDuration: AnyView(ExerciseDurationInfo()),
        .exerciseIntensity: AnyView(ExerciseIntensityInfo()),
        .programDuration: AnyView(ProgramDurationInfo())]

    var body: some View {
        if infoManager.showInfo {
            VStack {
                Spacer()

                content
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 300)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        withAnimation {
                            infoManager.hideInfo()
                        }
                    }
            }
            .transition(.move(edge: .bottom))
        }
    }

    var content: AnyView {
        if let page = infoManager.page {
            if let info = Self.infoPages[page] {
                return info
            }
            fatalError("No info content for \(page)")
        }
        fatalError("No info page set")
    }

}

struct InfoPanel_Previews: PreviewProvider {
    static var infoManager = InfoManager()

    static var previews: some View {
        infoManager.showInfo(for: .execiseType)

        return InfoPanel()
            .environmentObject(infoManager)
    }
}
