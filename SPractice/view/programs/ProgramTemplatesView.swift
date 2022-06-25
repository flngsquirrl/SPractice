//
//  ProgramTemplatesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramTemplatesView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        
        ForEach(dataModel.programTemplates) { template in
            HStack {
                if isInEditMode {
                    Text("\(template.name)")
                } else {
                    NavigationLink {
                        ProgramTemplateDetailsView(for: template) {
                            dataModel.updateProgramTemplate(template: $0)
                        } onDelete: {
                            dataModel.deleteProgramTemplate(template: $0)
                        }
                    } label: {
                        Text("\(template.name)")
                    }
                }
            }
        }
        .onDelete { dataModel.removeProgramItems(at: $0) }
        .onMove { dataModel.moveProgramItems(from: $0, to: $1) }
        .navigationTitle("Programs")
    }
}

struct ProgramsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ProgramTemplatesView()
            }
        }
    }
}
