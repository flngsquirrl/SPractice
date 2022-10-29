//
//  HomeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.04.22.
//

import SwiftUI

struct HomeView: View {

    @State private var contentType: ContentType = .programs

    private var tabsOrder: [ContentType] = [.programs, .exercises, .settings]
    private var tabs: [ContentType: AnyView]  = [
        .programs: AnyView(ProgramsView()),
        .exercises: AnyView(ExercisesView()),
        .settings: AnyView(SettingsView())]

    var body: some View {
        TabView(selection: $contentType) {
            ForEach(tabsOrder, id: \.self) { tabType in
                tabs[tabType]?
                    .tabItem {
                        Label(tabType.title, systemImage: tabType.image)
                    }
                    .tag(tabType)
            }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .accentColor(.customAccentColor)
    }
}

extension HomeView {
    enum ContentType: String, CaseIterable {
        case programs
        case exercises
        case settings

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

        var title: String {
            rawValue.capitalized
        }
    }
}

struct HomeView_Previews: PreviewProvider {

    static var activityMonitor = ActivityMonitor()
    static var settingsManager = SettingsManager()
    static var infoController = InfoController()

    static var previews: some View {
        HomeView()
            .environmentObject(activityMonitor)
            .environmentObject(settingsManager)
            .environmentObject(infoController)
    }
}
