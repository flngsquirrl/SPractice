//
//  HelpView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import SwiftUI

struct HelpView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var helpPage: HelpPage

    init(for helpPage: HelpPage) {
        self.helpPage = helpPage
    }

    var body: some View {
        NavigationStack {
            VStack {
                HelpPageContent(helpPage: helpPage)
                Spacer()
            }
            .if(isFullSized) {
                $0.navigationTitle("Help")
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isFullSized {
                    ToolbarItemGroup(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                } else {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.down")
                        }
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }

    var isFullSized: Bool {
        isRegularHorizontally || isCompactVertically
    }

    var isRegularHorizontally: Bool {
        horizontalSizeClass == .regular
    }

    var isCompactVertically: Bool {
        verticalSizeClass == .compact
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(for: .example)
    }
}
