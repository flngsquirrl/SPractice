//
//  MainManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.08.22.
//

import SwiftUI

@MainActor protocol MainManager: ObservableObject {

    associatedtype Item

    func addItem(_ item: Item)
    func updateItem(_ item: Item)
    func deleteItem(_ item: Item)
    func listItems() -> [Item]
}

@MainActor protocol ExercisesMainManager: MainManager where Item == ExerciseTemplate {}
@MainActor protocol ProgramsMainManager: MainManager where Item == ProgramTemplate {}
