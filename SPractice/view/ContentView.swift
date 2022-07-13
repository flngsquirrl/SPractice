//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var editMode: EditMode = .inactive
    
    @State private var showSettingsView = false
    @State private var showAddNewView = false
    
    @ObservedObject private var programs = Programs.shared
    @ObservedObject private var exercises = Exercises.shared
    
    @StateObject private var viewModel = ViewModel()
    
    @ObservedObject private var settings = SettingsManager.shared.settings
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.contentType {
                case .programs:
                    ProgramsView()
                case .exercises:
                    ExercisesView()
                }
            }
            .navigationTitle(viewModel.contentType == .exercises ? "Exercises" : "Programs")
            .sheet(isPresented: $showSettingsView) {
                viewModel.saveSettings()
            } content: {
                SettingsView()
            }
            .sheet(isPresented: $showAddNewView) {
                NavigationView {
                    if viewModel.contentType == .programs {
                        AddProgramView() { programs.addNew($0) }
                    } else {
                        AddExerciseView() { exercises.addNew($0) }
                    }
                }
                .accentColor(.customAccentColor)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Picker("Content type", selection: $viewModel.contentType.animation()) {
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
                        SortingMenu(onChange: { viewModel.setSorting(property: $0, order: $1) }, isSet: { viewModel.isSortingSet(property: $0, order: $1) })
                        
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
            
            WelcomeView()
        }
        .environmentObject(settings)
        .accentColor(.customAccentColor)
    }
    
    func getImageName(for type: ContentType) -> String {
        switch type {
        case .programs:
            return "heart.text.square"
        case .exercises:
            return "staroflife.circle"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
