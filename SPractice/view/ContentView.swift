//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    enum ContentType: String, CaseIterable {
        case programs = "Programs"
        case exercises = "Exercises"
    }
    
    @State private var editMode: EditMode = .inactive
    
    @State private var showSettingsView = false
    @State private var showAddNewView = false
    @State private var contentType: ContentType = .programs
    
    @ObservedObject var programsManager = ProgramsManager.shared
    @ObservedObject var exercisesManager = ExercisesManager.shared
    
    var body: some View {
        NavigationView {
            Group {
                switch contentType {
                case .programs:
                    ProgramsView()
                case .exercises:
                    ExercisesView()
                }
            }
            .navigationTitle(contentType == .exercises ? "Exercises" : "Programs")
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            .sheet(isPresented: $showAddNewView) {
                NavigationView {
                    if contentType == .programs {
                        AddProgramView() { programsManager.addNew(program: $0) }
                    } else {
                        AddExerciseView() { exercisesManager.addNew(exercise: $0) }
                    }
                }
                .accentColor(.customAccentColor)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Picker("Content type", selection: $contentType) {
                        ForEach(ContentType.allCases, id: \.self) { type in
                            Image(systemName: getImageName(for: type))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button() {
                        showAddNewView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Menu {
                        Button() {
                            showSettingsView = true
                        } label: {
                            Label("Open Settings", systemImage: "gearshape")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            
            ZStack {
                Color.lightOrange
                VStack {
                    SquirrelInWheelLogo()
                        .frame(width: 300, height: 300)
                }
            }
        }
        .accentColor(.customAccentColor)
    }
    
    func getImageName(for type: ContentType) -> String {
        switch type {
        case .programs:
            return "heart.text.square"
        case .exercises:
            return "heart"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
