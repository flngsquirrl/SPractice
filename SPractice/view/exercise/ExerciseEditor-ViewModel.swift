//
//  ExerciseEditor-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation
import SwiftUI

extension ExerciseEditor {
    
    static var secondsUnit: String {
        MeasurementFormatter().string(from: UnitDuration.seconds)
    }
    
    static var minutesUnit: String {
        MeasurementFormatter().string(from: UnitDuration.minutes)
    }
    
    @MainActor class ViewModel: ObservableObject {
        
        @Binding var exercise: ExerciseTemplate
        
        @Published var isTypeSet: Bool = true

        var areSecondsDisabled: Bool {
            minutes == 60
        }
        
        var tasks: [Task] {
            guard exercise.type != nil else {
                return []
            }
            
            return Exercise(from: exercise)?.tasks ?? []
        }
        
        @Published var minutes: Int = 0
        @Published var seconds: Int = 0
        
        var isTypeDefined: Bool {
            exercise.type != nil
        }
        
        var resetDurationDisabled: Bool {
            exercise.type != .timer || (minutes == 0 && seconds == 0)
        }
        
        var intensityDisabled: Bool {
            exercise.type == .tabata
        }
        
        var isTimer: Bool {
            exercise.type == .timer
        }
        
        static let secondsSelectionArray = Array(stride(from: 0, through: 50, by: 10))
        
        init(for template: Binding<ExerciseTemplate>) {
            self._exercise = template
            self.isTypeSet = self.exercise.type != nil
            
            if case .known(let time) = self.exercise.duration {
                let minutes = self.exercise.type == .timer ? ClockTime.getMinutes(of: time) : 0
                self._minutes = Published<Int>(initialValue: minutes)
                
                let seconds = self.exercise.type == .timer ? ClockTime.getSeconds(of: time) : 0
                self._seconds = Published<Int>(initialValue: seconds)
            }
        }
        
        func onMinutesChange(newValue: Int) {
            if newValue == 60 {
                seconds = 0
            }
            
            setDuration()
        }
        
        func onSecondsChange(newValue: Int) {
            setDuration()
        }
        
        func setDuration() {
            exercise.duration = .known(ClockTime.calculateDuration(minutes: minutes, seconds: seconds))
        }
        
        func onTypeSetChange(newValue: Bool) {
            if !newValue {
                exercise.type = nil
            } else {
                exercise.type = .flow
            }
            
            onTypeChange(newValue: exercise.type)
        }
        
        func onTypeChange(newValue: ExerciseType?) {
            exercise.intensityType = .activity
        }
        
        func resetDuration() {
            minutes = 0
            seconds = 0
        }
    }
}
