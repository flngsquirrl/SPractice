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
    
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        NavigationView {
            List {
                switch contentType {
                case .programs:
                    ProgramTemplatesView()
                case .exercises:
                    ExerciseTemplatesView()
                }
            }
            .navigationTitle(contentType == .exercises ? "Exercises" : "Programs")
            .animation(.default, value: editMode)
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            .sheet(isPresented: $showAddNewView) {
                NavigationView {
                    if contentType == .programs {
                        AddProgramTemplateView() { dataModel.addNewProgramTemplate(template: $0) }
                    } else {
                        AddExerciseTemplateView() { dataModel.addNewExerciseTemplate(template: $0) }
                    }
                }
                .accentColor(.customAccentColor)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Picker("Group of templates", selection: $contentType) {
                        ForEach(ContentType.allCases, id: \.self) { type in
                            Image(systemName: getImageName(for: type))
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(editMode.isEditing)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button() {
                        showAddNewView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(editMode.isEditing)
                    
                    if editMode.isEditing {
                        Button("Done") {
                            editMode = .inactive
                        }
                    } else {
                        Menu {
                            Button() {
                                editMode = .active
                            } label: {
                                Label("Edit List", systemImage: "pencil")
                            }
                            
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
            }
            .environmentObject(dataModel)
            .environment(\.editMode, $editMode)
            
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
