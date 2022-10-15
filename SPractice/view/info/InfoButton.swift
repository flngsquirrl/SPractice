//
//  InfoButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.07.22.
//

import SwiftUI

struct InfoButton: View {

    @EnvironmentObject var infoManager: InfoManager

    var page: InfoPage
    var isFooter: Bool

    init(for page: InfoPage, isFooter: Bool = false) {
        self.page = page
        self.isFooter = isFooter
    }

    var body: some View {
        Button {
            withAnimation {
                infoManager.showInfo(for: page)
            }
        } label: {
            Image(systemName: "info.circle")
        }
        .font(isFooter ? .footnote : nil)
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var infoManager = InfoManager()

    static var previews: some View {
        InfoButton(for: .example)
            .environmentObject(infoManager)

    }
}
