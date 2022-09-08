//
//  PracticeView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 31.08.22.
//

import Foundation
import SwiftUI

extension PracticeView {
    @MainActor class ViewModel: ObservableObject {

        var practice: Practice
        var settings: PracticeSettings

        var runningAtPracticeRestartRequest = false

        @Published var isPracticeDetailsShown = false
        @Published var needRestartConfirmation = false

        init(for practice: Practice, with settings: PracticeSettings) {
            self.practice = practice
            self.settings = settings
        }

        func saveSoundSetting(isOn: Bool) {
            settings.playSounds = isOn
            PracticeSettingsManager.shared.updateOrAdd(settings)
        }

        func processRestartRequest() {
            if practice.isStarted {
                runningAtPracticeRestartRequest = practice.isRunning
                practice.pauseClock()
                needRestartConfirmation = true
            } else {
                practice.restart()
            }
        }

        func resumeAfterRestartPractice() {
            if runningAtPracticeRestartRequest {
                practice.resumeClock()
            }
        }

        func toggleSound() {
            withAnimation {
                practice.toggleSound()
                saveSoundSetting(isOn: practice.isSoundOn)
            }
        }

        func showSummary() {
            isPracticeDetailsShown.toggle()
            practice.pauseClock()
        }

        var isRestartPracticeDisabled: Bool {
            practice.isFirstExercise && !practice.isCurrentExerciseStarted
        }

        func processScenePhaseChange(isActive: Bool) {
            if isActive {
                practice.resumeClock()
            } else {
                practice.pauseClock()
            }
        }
    }
}
