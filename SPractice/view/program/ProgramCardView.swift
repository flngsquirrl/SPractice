//
//  ProgramCardView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.07.22.
//

import SwiftUI

struct ProgramCardView<T>: View where T: Program {
    
    var program: T
    var isExample: Bool
    
    init(program: T) {
        self.program = program
        if program is ProgramTemplate {
            self.isExample = (program as! ProgramTemplate).isExample
        } else {
            self.isExample = false
        }
    }
    
    var body: some View {
        Section {
            HStack(alignment: .top) {
                if isExample {
                    Image(systemName: "bookmark")
                        .foregroundColor(.secondary)
                }
                Text(program.name)
                    .fontWeight(.semibold)
            }
            if showDescription {
                Text(program.description)
                    .foregroundColor(.secondary)
            }
        } footer: {
            if isExample {
                HStack(spacing: 0) {
                    Text("This is an example ")
                    InfoButton()
                }
            }
        }
    }
    
    var showDescription: Bool {
        !program.description.isEmpty
    }
}

struct ProgramCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramCardView(program: ProgramTemplate.personal)
    }
}