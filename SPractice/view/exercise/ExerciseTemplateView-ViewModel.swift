//
//  ExerciseTemplateView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension ExerciseTemplateView {
    
    static var secondsUnit: String {
        MeasurementFormatter().string(from: UnitDuration.seconds)
    }
    
    static var minutesUnit: String {
        MeasurementFormatter().string(from: UnitDuration.minutes)
    }
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name: String = ""
        @Published var description: String = ""
        @Published var isTypeSet: Bool = true
        @Published var type: Exercise.ExerciseType = .timer
        @Published var minutes: Int = 0
        @Published var seconds: Int = 0
        
        @Published var areSecondsEnabled = true
        
        static let secondsSelectionArray = Array(stride(from: 0, through: 50, by: 10))
        
        var isEditMode: Bool
        private var id: UUID
        
        init() {
            self.isEditMode = false
            self.id = UUID()
        }
        
        init(for template: ExerciseTemplate) {
            _name = Published(wrappedValue: template.name)
            
            if (template.type != nil) {
                _type = Published(wrappedValue: template.type!)
                self.isTypeSet = true
            } else {
                isTypeSet = false
            }
            
            let minutes = template.type == .timer ? ClockTime.getMinutes(of: template.duration!) : 0
            _minutes = Published(wrappedValue: minutes)
            
            let seconds = template.type == .timer ? ClockTime.getSeconds(of: template.duration!) : 0
            _seconds = Published(wrappedValue: seconds)
            
            isEditMode = true
            self.id = template.id
        }
        
        func onMinutesChange(newValue: Int) {
            if newValue == 60 {
                seconds = 0
                areSecondsEnabled = false
            } else {
                areSecondsEnabled = true
            }
        }
        
        func prepareNewExerciseTemplate() -> ExerciseTemplate {
            let duration = type == .timer ? ClockTime.calculateDuration(minutes: minutes, seconds: seconds) : nil
            let type = isTypeSet ? type : nil
            return ExerciseTemplate(id: id, type: type, name: name, duration: duration)
        }
        
        func resetDuration() {
            minutes = 0
            seconds = 0
        }
    }
}
