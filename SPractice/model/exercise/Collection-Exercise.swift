//
//  ExerciseUtils.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.10.22.
//

import Foundation

extension Collection where Self.Element: Exercise {

    func hasFlowExercises() -> Bool {
        let haveFlow = self.contains(where: {
            $0.type == .flow
        })
        return haveFlow
    }
}
