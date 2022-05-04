//
//  NewExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.05.22.
//

import SwiftUI

struct NewExerciseView: View {
    
    @State private var name: String = ""
    @State private var type: ExerciseType = .timer
    @State private var minutes: Int = 1
    @State private var seconds: Int = 0
    
    var body: some View {
        Form {
            TextField("Exercise name", text: $name)
            
            Picker("Exercise type", selection: $type) {
                ForEach(ExerciseType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            if (type == .timer) {
                HStack {
                    Picker("Duration minutes", selection: $minutes) {
                        ForEach(0..<60) {
                            Text("\($0)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text("min")
                    Text(":")
                    
                    Picker("Duration seconds", selection: $seconds) {
                        ForEach(0..<60) {
                            Text("\($0)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text("sec")
                }
            }
        }
        .navigationTitle("New exercise")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup {
                Button("Save", action: save)
            }
        }
    }
    
    func save() {
        // todo
    }
}

struct NewExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewExerciseView()
        }
    }
}
