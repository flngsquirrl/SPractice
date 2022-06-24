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
    
    @State private var showSettingsView = false
    @State private var contentType: ContentType = .programs
    
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
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button() {
                        showSettingsView = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                
                    Picker("Group of templates", selection: $contentType.animation()) {
                        ForEach(ContentType.allCases, id: \.self) { type in
                            Image(systemName: getImageName(for: type))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .accentColor(.customAccentColor)
    }
    
    func getImageName(for type: ContentType, isSelected: Bool = false) -> String {
        let postfix = isSelected ? ".fill" : ""
        switch type {
        case .programs:
            return "heart.text.square\(postfix)"
        case .exercises:
            return "heart\(postfix)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
