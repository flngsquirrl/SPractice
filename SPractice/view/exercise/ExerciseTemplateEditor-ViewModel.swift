//
//  ExerciseTemplateEditor-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation
import SwiftUI

extension ExerciseTemplateEditor {
    
    static var secondsUnit: String {
        MeasurementFormatter().string(from: UnitDuration.seconds)
    }
    
    static var minutesUnit: String {
        MeasurementFormatter().string(from: UnitDuration.minutes)
    }
    
    @MainActor class ViewModel: ObservableObject {
        
        @Binding var template: ExerciseTemplate
        
        @Published var isTypeSet: Bool = true

        @Published var areSecondsEnabled = true
        @Published var minutes: Int = 0
        @Published var seconds: Int = 0
        
        var isTimer: Bool {
            template.type == .timer
        }
        
        static let secondsSelectionArray = Array(stride(from: 0, through: 50, by: 10))
        
        init(for template: Binding<ExerciseTemplate>) {
            self._template = template
            self.isTypeSet = self.template.type != nil
            
            if let duration = self.template.duration {
                let minutes = self.template.type == .timer ? ClockTime.getMinutes(of: duration) : 0
                self._minutes = Published<Int>(initialValue: minutes)
                
                let seconds = self.template.type == .timer ? ClockTime.getSeconds(of: duration) : 0
                self._seconds = Published<Int>(initialValue: seconds)
            }
        }
        
        func onMinutesChange(newValue: Int) {
            if newValue == 60 {
                seconds = 0
                areSecondsEnabled = false
            } else {
                areSecondsEnabled = true
            }
            
            setDuration()
        }
        
        func onSecondsChange(newValue: Int) {
            setDuration()
        }
        
        func setDuration() {
            template.duration = ClockTime.calculateDuration(minutes: minutes, seconds: seconds)
        }
        
        func onTypeSetChange(newValue: Bool) {
            if !newValue {
                template.type = nil
            } else {
                template.type = .flow
            }
        }
        
        func resetDuration() {
            minutes = 0
            seconds = 0
        }
    }
}
