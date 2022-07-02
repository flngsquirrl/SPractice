//
//  ExerciseTypeImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct ExerciseTypeImage: View {
    
    var type: ExerciseType?
    var isFilled = false

    var body: some View {
        Image(systemName: Self.imageName(for: type, isFilled: isFilled))
    }
    
    static func imageName(for type: ExerciseType?, isFilled: Bool = false) -> String {
        let postfix = isFilled ? ".fill" : ""
        if let type = type {
            switch type {
            case .flow:
                return "heart.circle\(postfix)"
            case .timer:
                return "clock\(postfix)"
            case .tabata:
                return "arrow.triangle.2.circlepath.circle\(postfix)"
            }
        } else {
            return "questionmark.circle\(postfix)"
        }
    }
}

struct ExerciseTypeImage_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ExerciseTypeImage(type: .flow)
            ExerciseTypeImage(type: .timer)
            ExerciseTypeImage(type: .tabata)
            ExerciseTypeImage(type: nil)
            
            ExerciseTypeImage(type: .flow, isFilled: true)
            ExerciseTypeImage(type: .timer, isFilled: true)
            ExerciseTypeImage(type: .tabata, isFilled: true)
            ExerciseTypeImage(type: nil, isFilled: true)
        }
    }
}
