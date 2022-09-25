//
//  FlowSettingsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct FlowSettingsView: View {

    @EnvironmentObject var manager: SettingsManager

    var body: some View {
        Section {
            Toggle("Auto-finish", isOn: $manager.flowAutoFinishItem.value.animation())
                .decorated()
        } header: {
            Text("Practice")
        } footer: {
            VStack {
                if manager.flowAutoFinishItem.value {
                    Text("Flow exercises will be finished automatically")
                } else {
                    Text("Flow exercises will be finished when you move to another exercise or finish the practice")
                }
            }
        }

        if manager.flowAutoFinishItem.value {
            Section {
                DurationControl(minutes: $manager.flowAutoFinishAfterTimeItem.value.minutes,
                                seconds: $manager.flowAutoFinishAfterTimeItem.value.seconds) {
                    Text("After")
                    Spacer()
                }
            } footer: {
                Text("You can still finish earlier moving to another exercise or finishing the practice")
            }
        }

        ResetToDefaultsButton(subgroup: .flow)
    }
}

struct FlowSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                FlowSettingsView()
            }
        }
    }
}
