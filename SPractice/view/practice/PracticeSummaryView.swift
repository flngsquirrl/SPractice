//
//  PracticeSummaryView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import SwiftUI

struct PracticeSummaryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var practice: Practice
    
    var body: some View {
        NavigationView {
            List {
                ProgramSummaryView(program: practice.program)
            }
            .navigationTitle(practice.program.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct PracticeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeSummaryView(practice: Practice(from: ProgramTemplate.personal))
    }
}
