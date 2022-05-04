//
//  NewProgramView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct NewProgramView: View {
    
    @State var name = ""
    @State var addRest = false
    @State var exercises: [ExerciseTemplate]
    
    var body: some View {
        Form {
            TextField("Program name", text: $name)
            Toggle("Add rest intervals", isOn: $addRest)
            
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
