//
//  ExerciseTypeImage.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct ExerciseTypeImage: View {
    
    var type: Exercise.ExerciseType?

    var body: some View {
        Image(systemName: Self.imageName(for: type))
    }
    
    static func imageName(for type: Exercise.ExerciseType?) -> String {
        if let type = type {
            switch type {
            case .flow:
                return "heart.circle.fill"
            case .timer:
                return "clock.fill"
            case .tabata:
                return "t.circle.fill"
            }
        } else {
            return "questionmark.circle"
        }
    }
}

struct ExerciseTypeImage_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTypeImage()
    }
}
