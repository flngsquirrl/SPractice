//
//  HomeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct HomeView: View {

    @State private var contentType: ContentType = .programs

    var body: some View {
        TabView(selection: $contentType) {
            ProgramsView()
                .tabItem {
                    Label(ContentType.programs.rawValue, systemImage: ContentType.programs.image)
                }
                .tag(ContentType.programs)

            ExercisesView()
                .tabItem {
                    Label(ContentType.exercises.rawValue, systemImage: ContentType.exercises.image)
                }
                .tag(ContentType.exercises)

            SettingsView()
                .tabItem {
                    Label(ContentType.settings.rawValue, systemImage: ContentType.settings.image)
                }
                .tag(ContentType.settings)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .accentColor(.customAccentColor)
    }

    enum ContentType: String, CaseIterable {
        case programs = "Programs"
        case exercises = "Exercises"
        case settings = "Settings"

        var image: String {
            switch self {
            case .programs:
                return "heart.text.square"
            case .exercises:
                return "staroflife.circle"
            case .settings:
                return "gearshape"
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {

    static var activityMonitor = ActivityMonitor()
    static var settingsManager = SettingsManager()
    static var infoManager = InfoManager()

    static var previews: some View {
        HomeView()
            .environmentObject(activityMonitor)
            .environmentObject(settingsManager)
            .environmentObject(infoManager)
    }
}
