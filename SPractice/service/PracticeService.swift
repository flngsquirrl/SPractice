//
//  PracticeService.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.09.22.
//

import Foundation

class PracticeService: ObservableObject {

    var settingsManager = SettingsManager()

    func prepareForPractice(_ template: ProgramTemplate, useRest: Bool = false) -> PracticeProgram {
        var program = PracticeProgram()

        program.name = template.name.trim()
        program.description = template.description.trim()

        var baseExercises = [PracticeExercise]()
        for exerciseTemplate in template.exercises {
            let exercise = prepareForPractice(exerciseTemplate)
            baseExercises.append(exercise!)
        }

        program.exercises = prepareForPractice(exercises: baseExercises, useRest: useRest)
        program.useRest = useRest

        program.isExample = template.isExample
        program.exampleId = template.exampleId

        return program
    }

    func prepareForPractice(exercises: [PracticeExercise], useRest: Bool = false) -> [PracticeExercise] {
        if !useRest {
            return exercises
        }

        var all = [PracticeExercise]()
        for (index, exercise) in exercises.enumerated() {
            all.append(exercise)
            if index != exercises.count - 1 {
                let pause = prepareForPractice(ExerciseTemplate.restTemplate)
                all.append(pause!)
            }
        }
        return all
    }

    func prepareForPractice(_ template: ExerciseTemplate) -> PracticeExercise? {
        guard template.type != nil else {
            return nil
        }

        var exercise = PracticeExercise()
        let name = template.isService ? settingsManager.restName : template.name
        exercise.type = template.type!
        exercise.name = name.trim()
        exercise.description = template.description.trim()
        exercise.intensity = template.intensity!
        exercise.isService = template.isService
        exercise.isExample = template.isExample
        exercise.exampleId = template.exampleId
        exercise.tasks = prepareTasks(from: template)

        return exercise
    }

    func prepareTasks(from template: ExerciseTemplate) -> [Task] {
        var tasks = [Task]()

        if let type = template.type {
            switch type {
            case .flow:
                tasks = prepareFlowTasks(from: template)
            case .tabata:
                tasks = prepareTabataTasks(from: template)
            case .timer:
                tasks = prepareTimerTasks(from: template)
            }
        }

        return tasks
    }

    private func prepareTabataTasks(from template: ExerciseTemplate) -> [Task] {
        var tasks = [Task]()

        let warmUp = Task(intensity: .rest, name: "warm-up", duration: .known(settingsManager.tabataWarmUpDurationItem.value))
        tasks.append(warmUp)

        let tabataCycles = settingsManager.tabataCyclesItem.value
        for number in 1...tabataCycles {
            let activity = Task(intensity: .activity, name: "\(Intensity.activity.rawValue) \(number)",
                                duration: .known(settingsManager.tabataActivityDurationItem.value))
            let rest = Task(intensity: .rest, name: "\(Intensity.rest.rawValue) \(number)",
                            duration: .known(settingsManager.tabataRestDurationItem.value))
            tasks.append(activity)
            tasks.append(rest)
        }

        let coolDown = Task(intensity: .rest, name: "cool-down", duration: .known(settingsManager.tabataCoolDownDurationItem.value))
        tasks.append(coolDown)

        return tasks
    }

    private func prepareFlowTasks(from template: ExerciseTemplate) -> [Task] {
        let task = Task(intensity: template.intensity!, name: template.intensity!.rawValue, duration: .unlimited)
        return [Task].wrapElement(element: task)
    }

    private func prepareTimerTasks(from template: ExerciseTemplate) -> [Task] {
        let intensity: Intensity = template.isService ? .rest : template.intensity!
        let duration: Duration = template.isService ? .known(settingsManager.restDurationItem.value) : template.duration
        let task = Task(intensity: intensity, name: intensity.rawValue, duration: duration)
        return [Task].wrapElement(element: task)
    }

}
