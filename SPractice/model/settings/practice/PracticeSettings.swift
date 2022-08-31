//
//  PracticeSettings.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.08.22.
//

import Foundation

struct PracticeSettings: Identifiable, Equatable, Codable, HavingID {

    var programId: UUID
    var addRestIntervals: Bool = false
    var pauseAfterExercise: Bool = false
    var playSounds: Bool = true

    var id: UUID {
        programId
    }
}
