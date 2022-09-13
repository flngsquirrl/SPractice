//
//  InfoButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.07.22.
//

import SwiftUI

struct InfoButton: View {

    var helpPage: HelpPage
    var isFooter: Bool

    @State private var showHelp = false

    init(for helpPage: HelpPage, isFooter: Bool = false) {
        self.helpPage = helpPage
        self.isFooter = isFooter
    }

    var body: some View {
        Button {
            showHelp = true
        } label: {
            Image(systemName: "info.circle")
        }
        .font(isFooter ? .footnote : nil)
        .sheet(isPresented: $showHelp) {
            HelpView(for: helpPage)
                .presentationDetents([.fraction(0.6)])
        }
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton(for: .example)
    }
}
