//
//  PracticeView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 31.08.22.
//

import Foundation

extension PracticeView {
    @MainActor class ViewModel: SignalChangeListener {

        var practice: Practice
        var settings: PracticeSettings

        var runningAtPracticeRestartRequest = false

        @Published var isPracticeDetailsShown = false
        @Published var needRestartConfirmation = false

        private let settingsManager = PracticeSettingsManager()

        init(for template: ProgramTemplate) {
            let settings = settingsManager.getSettings(for: template.id)
            self.settings = settings
            self.practice = Practice(for: template, with: settings)

            super.init()

            listenTo(target: practice.objectWillChange)
        }

        func saveSoundSetting(isOn: Bool) {
            settings.playSounds = isOn
            settingsManager.updateOrAdd(settings)
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
            practice.toggleSound()
            saveSoundSetting(isOn: practice.isSoundOn)
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
