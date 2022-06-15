//
//  PracticeSequenceView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.05.22.
//

import SwiftUI

struct PracticeSequenceView: View {
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        VStack {
            ForEach(ExerciseSequence(for: practice.preview(), with: practice.currentExercise).sequence) { item in
                    PracticeSequenceRowView(item: item)
            }
        }
        .padding()
        .background(.creamy)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct ExerciseSequence {
    
    let sequence: [ExerciseSequenceItem]
    
    init(for exercises: [Exercise], with current: Exercise) {
        var wrappedExercises: [ExerciseSequenceItem] = []
        var mark: ExerciseSequenceItem.SequenceMark = .previous
        for exercise in exercises {
            let isCurrent = exercise.id == current.id
            let markToSet: ExerciseSequenceItem.SequenceMark = isCurrent ? .current : mark
            wrappedExercises.append(ExerciseSequenceItem(exercise: exercise, sequenceMark: markToSet))
            if isCurrent {
                mark = .next
            }
        }
        self.sequence = wrappedExercises
    }
    
}

struct ExerciseSequenceItem: Identifiable{
    
    let exercise: Exercise
    let sequenceMark: SequenceMark
    
    var id: UUID {
        exercise.id
    }
    
    enum SequenceMark {
        case previous
        case current
        case next
    }
}

struct PracticeSequenceRowView: View {
    
    var item: ExerciseSequenceItem
    
    var body: some View {
        if item.sequenceMark == .current {
            ExerciseDetailsShortView(for: item.exercise, iconColor: .lightOrange)
        } else {
            ExerciseDetailsShortView(for: item.exercise)
        }
    }
}

struct PracticeSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.lightNavy
                .ignoresSafeArea()
            PracticeSequenceView(practice: Practice(for: Program(from: ProgramTemplate.personal)))
                .frame(width: 320)
        }
    }
}
