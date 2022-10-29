//
//  InfoButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.07.22.
//

import SwiftUI

struct InfoButton: View {

    @EnvironmentObject var infoController: InfoController

    var page: InfoPage
    var isFooter: Bool

    init(for page: InfoPage, isFooter: Bool = false) {
        self.page = page
        self.isFooter = isFooter
    }

    var body: some View {
        Button {
            withAnimation {
                infoController.showInfo(for: page)
            }
        } label: {
            Image(systemName: "info.circle")
        }
        .font(isFooter ? .footnote : nil)
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var infoController = InfoController()

    static var previews: some View {
        InfoButton(for: .example)
            .environmentObject(infoController)

    }
}
