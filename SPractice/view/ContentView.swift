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
    
    @ObservedObject var programs = Programs.shared
    var programSelection = ProgramSelectionManager.shared
    @ObservedObject var exercises = Exercises.shared
    var exerciseSelection = ExerciseSelectionManager.shared
    
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
            .clipped()
            .navigationTitle(viewModel.contentType == .exercises ? "Exercises" : "Programs")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            .sheet(isPresented: $showAddNewView) {
                if viewModel.contentType == .programs {
                    AddProgramView() {
                        programs.addNew($0)
                        programSelection.onNewItemAdded(id: $0.id, isRegularSize: isRegularSize)
                    }
                } else {
                    AddExerciseView() {
                        exercises.addNew($0)
                        exerciseSelection.onNewItemAdded(id: $0.id, isRegularSize: isRegularSize)
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    contentTypePicker
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
    
    @ViewBuilder var contentTypePicker: some View {
        ForEach(ContentType.allCases, id: \.self) { type in
            Spacer()
            Button {
                withAnimation {
                    viewModel.contentType = type
                }
            } label: {
                VStack {
                    Image(systemName: getImageName(for: type))
                    Text(type.rawValue)
                        .font(.caption2)
                }
                .foregroundColor(type == viewModel.contentType ? .customAccentColor : .secondary)
            }
            Spacer()
        }
        .onChange(of: viewModel.contentType) { _ in
            processContentTypeChange()
        }
    }
    
    func processContentTypeChange() {
        if isRegularSize {
            programSelection.switchInUse()
            exerciseSelection.switchInUse()
        }
    }
    
    var isRegularSize: Bool {
        sizeClass == .regular
    }
    
    func getImageName(for type: ContentType) -> String {
        switch type {
        case .programs:
            return "heart.text.square.fill"
        case .exercises:
            return "staroflife.circle.fill"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
