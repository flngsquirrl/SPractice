//
//  ExerciseTypeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import SwiftUI

struct ExerciseTypeView: IconTextView {
    
    var type: ExerciseType?
    var mode: IconTextMode = .icon
    
    var icon: some View {
        ExerciseTypeImage(type: type)
    }
    
    var text: some View {
        if let type = type {
            Text(type.rawValue)
        } else {
            Text("unknown")
        }
    }
}

struct ExerciseTypeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Text("timer")
            ExerciseTypeView(type: .timer, mode: .icon)
            ExerciseTypeView(type: .timer, mode: .text)
            ExerciseTypeView(type: .timer, mode: .iconAndText)
            Text("unknown")
            ExerciseTypeView(type: nil, mode: .icon)
            ExerciseTypeView(type: nil, mode: .text)
            ExerciseTypeView(type: nil, mode: .iconAndText)
        }
    }
}
