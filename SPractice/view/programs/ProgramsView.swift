//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {

    @ObservedObject var controller = ProgramsController.shared

    var componentsProvider = ProgramsComponents()

    var body: some View {
        MainList(controller: controller, componentsProvider: componentsProvider)
    }
}

struct ProgramsView_Previews: PreviewProvider {

    static var infoController = InfoController()

    static var previews: some View {
        ProgramsView()
            .environmentObject(infoController)
    }
}
