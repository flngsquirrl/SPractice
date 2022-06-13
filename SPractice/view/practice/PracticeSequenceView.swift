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
        HStack {
            Group {
                switch item.sequenceMark {
                case .previous:
                    Image(systemName: "arrowtriangle.up.fill")
                case .current:
                    //Image(systemName: "smallcircle.filled.circle")
                    Image(systemName: "arrowtriangle.forward.fill")
                case .next:
                    Image(systemName: "arrowtriangle.down.fill")
                }
            }
            .foregroundColor(.lightOrange)
            
            ExerciseDetailsShortView(for: item.exercise)
                
        }
        .padding(10)
        .background(.creamy)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .transition(.slide)
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
