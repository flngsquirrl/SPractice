//
//  ExerciseTemplateView-ViewModel.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.06.22.
//

import Foundation

extension ExerciseTemplateView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var name: String = ""
        @Published var type: Exercise.ExerciseType = .timer
        @Published var minutes: Int = 1
        @Published var seconds: Int = 0
        
        @Published var isEditMode: Bool
        private var id: UUID
        
        init() {
            self.isEditMode = false
            self.id = UUID()
        }
        
        init(for template: ExerciseTemplate) {
            _name = Published(wrappedValue: template.name)
            _type = Published(wrappedValue: template.type)
            
            let minutes = template.type == .timer ? Clock.getMinutes(of: template.duration!) : 0
            _minutes = Published(wrappedValue: minutes)
            
            let seconds = template.type == .timer ? Clock.getSeconds(of: template.duration!) : 0
            _seconds = Published(wrappedValue: seconds)
            
            isEditMode = true
            self.id = template.id
        }
        
        func prepareNewExerciseTemplate() -> ExerciseTemplate {
            let duration = type == .timer ? Clock.calculateDuration(minutes: minutes, seconds: seconds) : nil
            return ExerciseTemplate(id: id, type: type, name: name, duration: duration)
        }
    }
}
