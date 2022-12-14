//
//  PracticeExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PracticeExerciseView: View {

    @ObservedObject var practice: Practice

    @State var showDetails = false

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                typeImage

                Spacer()

                RoundIconButton(imageName: "info.circle.fill", disabled: false) {
                    showDetails = true
                    practice.pauseClock()
                }

                RoundIconButton(imageName: "arrow.clockwise.circle.fill", disabled: !practice.isCurrentExerciseStarted) {
                    practice.restartExercise()
                }
                .animation(.default, value: practice.isCurrentExerciseStarted)
            }

            VStack(alignment: .center) {
                Text("\(practice.currentExercise.name)")
                    .multilineTextAlignment(.center)
                    .font(.title2.bold())
                    .lineLimit(2)
                    .padding()
            }
            .frame(minHeight: 100)

            Text("\(practice.currentExercise.unwrappedType.rawValue)")
                .font(.body.bold())
                .foregroundColor(.secondary)

            ClockView(clock: practice.clock)
            Text("\(practice.currentTask.name)")
                .font(.body.bold())
                .foregroundColor(.secondary)
        }
        .sheet(isPresented: $showDetails) {
            practice.resumeClock()
        } content: {
            PracticeExerciseInfoView(exercise: practice.currentExercise)
        }
    }

    var typeImage: some View {
        Image(systemName: ExerciseTypeImage.imageName(for: practice.currentExercise.type, isFilled: true))
            .resizable()
            .scaledToFit()
            .opacity(0.8)
            .frame(width: 35, height: 35)
            .foregroundColor(.mainColor)
            .font(.largeTitle.bold())
    }
}

struct PracticeExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            PracticeExerciseView(practice: Practice(for: .simpleYoga, with: PracticeSettings(programId: ProgramTemplate.simpleYoga.id)))
                .wrapped()
                .frame(width: 320)

        }
    }
}
