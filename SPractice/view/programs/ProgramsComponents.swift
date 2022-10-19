//
//  ProgramsComponents.swift
//  SPractice
//
//  Created by Yuliya Charniak on 19.10.22.
//

import Foundation

struct ProgramsComponents: ListComponentsProvider {

    typealias Item = ProgramTemplate

    var title: String {
        "Programs"
    }

    var addItemView: AddProgramView {
        AddProgramView()
    }

    func getShortView(item: ProgramTemplate, isAccented: Bool) -> ProgramShortDecorativeView {
        return ProgramShortDecorativeView(for: item, isAccented: isAccented)
    }

    func getDetailsView(item: ProgramTemplate) -> ProgramDetailsView {
        ProgramDetailsView(for: item)
    }
}
