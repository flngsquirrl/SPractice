//
//  ExerciseEditor-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation
import SwiftUI

extension ExerciseEditor {
    @MainActor class ViewModel: ObservableObject {
        
        @Binding var template: EditorTemplate
        
        @Published var isTypeSet: Bool = true
        @Published var minutes: Int = 0
        @Published var seconds: Int = 0
        
        init(for template: Binding<EditorTemplate>) {
            self._template = template
            self.isTypeSet = self.template.type != nil
            
            if case .known(let time) = self.template.duration {
                let minutes = self.template.type == .timer ? ClockTime.getMinutes(of: time) : 0
                self._minutes = Published<Int>(initialValue: minutes)
                
                let seconds = self.template.type == .timer ? ClockTime.getSeconds(of: time) : 0
                self._seconds = Published<Int>(initialValue: seconds)
            }
        }
        
        var exercise: ExerciseTemplate {
            return ExerciseTemplate(from: template)
        }
        
        var isTypeDefined: Bool {
            template.type != nil
        }
        
        var resetDurationDisabled: Bool {
            template.type != .timer || (minutes == 0 && seconds == 0)
        }
        
        var showDurationFooter: Bool {
            template.type == .flow || template.type == .tabata
        }
        
        var showIntensity: Bool {
            template.type != nil
        }
        
        var showIntensitySelection: Bool {
            template.type != nil && template.type != .tabata
        }
        
        var showTasks: Bool {
            template.type != nil && template.type == .tabata
        }
        
        var showReset: Bool {
            template.type != nil && template.type == .timer
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
            template.duration = .known(ClockTime.calculateDuration(minutes: minutes, seconds: seconds))
        }
        
        func onTypeSetChange(newValue: Bool) {
            if !newValue {
                template.type = nil
            } else {
                template.type = .flow
            }
        }
    }
    
    struct EditorTemplate: Exercise {
        var id: UUID
        var type: ExerciseType? {
            didSet {
                updateDuration()
                updateIntensity()
            }
        }
        var name: String
        var description: String
        var intensity: Intensity? // not set when type not set
        var duration: Duration
        var isService: Bool
        
        init(from template: ExerciseTemplate) {
            self.id = template.id
            self.name = template.name
            self.description = template.description
            self.type = template.type
            self.intensity = template.intensity
            self.duration = template.duration
            self.isService = template.isService
        }
        
        mutating func updateDuration() {
            if type == .flow {
                duration = .unlimited
            } else {
                duration = .unknown
            }
        }
        
        mutating func updateIntensity() {
            if let type = type {
                if type == .tabata {
                    intensity = .mixed
                } else {
                    intensity = .activity
                }
            } else {
                intensity = nil
                duration = .unknown
            }
        }
        
        var exercise: ExerciseTemplate {
            return ExerciseTemplate(from: self, changeId: false)
        }
    }
}
