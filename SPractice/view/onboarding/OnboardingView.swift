//
//  OnboardingView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.09.22.
//

import SwiftUI

enum IntroTab {
    case exercises
    case programs
    case app
}

struct OnboardingView: View {

    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedTab = IntroTab.exercises

    var body: some View {
        ZStack {
            Color.lightOrange
                .ignoresSafeArea()

            TabView(selection: $selectedTab) {
                IntroExercisesView()
                    .tag(IntroTab.exercises)

                IntroProgramsView()
                    .tag(IntroTab.programs)

                IntroAppView()
                    .tag(IntroTab.app)
            }
            .tabViewStyle(.page)

            VStack {
                Spacer()
                HStack {
                    if selectedTab != .app {
                        Button("Skip") {
                            close()
                        }
                    }
                    Spacer()
                    if selectedTab == .app {
                        Button("Start") {
                            close()
                        }
                    } else {
                        Button("Next") {

                        }
                    }
                }
                .padding()
                .foregroundColor(.white)
                .buttonStyle(.plain)
            }
        }
    }

    func close() {
        withAnimation {
            viewRouter.goHome()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
