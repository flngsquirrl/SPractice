//
//  NewProgramView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct NewProgramView: View {
    
    @State var name = ""
    @State var addRest = true
    @State var exercises: [ExerciseTemplate]
    
    var body: some View {
        Form {
            TextField("Program name", text: $name)
            
            Section {
                Toggle("Add rest intervals", isOn: $addRest)
            } footer: {
                Text("Having rest between execises lets you take a deep breath and prepare for the upcoming exercise properly")
            }
            
            Section("Exercises") {
                List {
                    ForEach(exercises) { exercise in
                        HStack {
                            Text(exercise.name)
                            Spacer()
                            Text(exercise.type.rawValue)
                        }
                    }
                }
            }
        }
        .navigationTitle("New program")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup {
                Button("Save", action: save)
            }
        }
    }
    
    func save() {
        
    }
}

struct NewProgramView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewProgramView(exercises: [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar])
        }
    }
}
