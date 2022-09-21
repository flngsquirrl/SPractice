//
//  ExerciseDurationView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 21.09.22.
//

import Foundation
import Combine

extension ExerciseDurationView {
    @MainActor class ViewModel: ViewModelListener {

        private let template: T

        let publishersToListen = [SettingsManager.restDurationItem.objectWillChange,
                                  SettingsManager.tabataWarmUpDurationItem.objectWillChange,
                                  SettingsManager.tabataActivityDurationItem.objectWillChange,
                                  SettingsManager.tabataRestDurationItem.objectWillChange,
                                  SettingsManager.tabataWarmUpDurationItem.objectWillChange,
                                  SettingsManager.tabataCyclesItem.objectWillChange]

        init(for template: T) where T: Exercise {
            self.template = template
            super.init()

            listenTo(targets: publishersToListen)
        }

        var duration: Duration {
            if template.type == .tabata {
                return .known(SettingsManager.tabataExerciseDuration)
            } else if template.isService {
                return .known(SettingsManager.restDurationItem.value)
            } else {
                return template.duration
            }
        }
    }
}
