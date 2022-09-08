//
//  ContentView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 6.09.22.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.scenePhase) var scenePhase

    @StateObject var activityMonitor = ScenePhaseMonitor()
    @StateObject var viewRouter = ViewRouter()

    var body: some View {
        Group {
            switch viewRouter.currentView {
            case .home:
                HomeView()
                    .environmentObject(activityMonitor)
                    .transition(.opacity)
            case .onboarding:
                OnboardingView()
                    .environmentObject(viewRouter)
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .welcome:
                WelcomeView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                viewRouter.goHome()
                            }
                        }
                    }
            default:
                Color.lightOrange
                    .ignoresSafeArea()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
                activityMonitor.activate()
            } else {
                print("Inactive")
                activityMonitor.inactivate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
