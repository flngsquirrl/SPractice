//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var editMode: EditMode = .inactive
    
    @State private var showSettingsView = false
    @State private var showAddNewView = false
    
    @ObservedObject private var programs = Programs.shared
    @ObservedObject private var exercises = Exercises.shared
    
    @StateObject private var viewModel = ViewModel()
    
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
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            .sheet(isPresented: $showAddNewView) {
                if viewModel.contentType == .programs {
                    AddProgramView() { programs.addNew($0, updateSelection: showNewItemAfterCreation) }
                } else {
                    AddExerciseView() { exercises.addNew($0, updateSelection: showNewItemAfterCreation) }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Picker("Content type", selection: $viewModel.contentType.animation()) {
                        ForEach(ContentType.allCases, id: \.self) { type in
                            Image(systemName: getImageName(for: type))
                        }
                    }
                    .fixedSize()
                    .pickerStyle(.segmented)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button() {
                        showAddNewView = true
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 25)
                    }
                    
                    Menu {
                        SortingMenu(sortProperty: viewModel.sortProperty, sortOrder: viewModel.sortOrder)
                            { viewModel.setSorting(property: $0, order: $1) }
                        
                        Button() {
                            showSettingsView = true
                        } label: {
                            Label("Open Settings", systemImage: "gearshape")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .frame(width: 25)
                    }
                }
            }
            
            WelcomeView()
        }
        .accentColor(.customAccentColor)
    }
    
    var showNewItemAfterCreation: Bool {
        sizeClass == .regular
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
