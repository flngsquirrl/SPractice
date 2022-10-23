//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {

    @ObservedObject var controller = ExercisesController.shared

    var componentsProvider = ExercisesComponents()

    var body: some View {
        MainList(controller: controller, componentsProvider: componentsProvider)
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var infoManager = InfoManager()

    static var previews: some View {
        ExercisesView()
            .environmentObject(infoManager)
    }
}
