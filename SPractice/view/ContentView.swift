//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSettingsView = false
    @State private var contentType: ContentType = .programs
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Group of templates", selection: $contentType.animation()) {
                        ForEach(ContentType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                    
                    
                switch contentType {
                case .programs:
                    ProgramsView()
                case .exercises:
                    ExerciseTemplatesView()
                }
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            .navigationTitle("Templates")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        showSettingsView = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .accentColor(.customAccentColor)
    }
    
    enum ContentType: String, CaseIterable {
        case programs = "Programs"
        case exercises = "Exercises"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
