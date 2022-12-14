//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import Resolver
import SwiftUI

struct ContentView: View {

    @Environment(\.scenePhase) var scenePhase

    @Injected var settingsManager: SettingsManager

    @StateObject var viewRouter = ViewRouter()
    var activityMonitor = ActivityMonitor()

    var body: some View {
        Group {
            switch viewRouter.currentView {
            case .home:
                HomeView()
                    .environmentObject(activityMonitor)
                    .environmentObject(settingsManager)
                    .transition(.opacity)
            case .onboarding:
                OnboardingView()
                    .environmentObject(viewRouter)
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .welcome:
                WelcomeView()
                    .transition(.opacity)
                    .task {
                        await goHome()
                    }
            default:
                Color.mainColor
                    .ignoresSafeArea()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                activityMonitor.activate()
            } else {
                activityMonitor.inactivate()
            }
        }
    }

    private func goHome() async {
        try? await _Concurrency.Task.sleep(seconds: 1)
        withAnimation {
            viewRouter.goHome()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
