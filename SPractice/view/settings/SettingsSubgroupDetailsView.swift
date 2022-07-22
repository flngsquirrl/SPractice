//
//  SettingsSubgroupView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.07.22.
//

import SwiftUI

struct SettingsSubgroupDetailsView: View {
    
    @State private var showResetConfirmation = false
    
    var subgroup: SettingsSubGroup
    
    var body: some View {
        List {
            getSubgroupView(subgroup)
        }
        .navigationTitle(subgroup.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear() {
            SettingsManager.saveSettings()
        }
    }
    
    func getSubgroupView(_ subgroup: SettingsSubGroup) -> AnyView {
        switch subgroup {
        case .tabata:
            return AnyView(TabataSettingsView())
        case .flow:
            return AnyView(FlowSettingsView())
        case .pause:
            return AnyView(PauseSettingsView())
        case .examples:
            return AnyView(ExamplesSettingsView())
        }
    }
}

struct SettingsSubgroupDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsSubgroupDetailsView(subgroup: .tabata)
        }
        
        NavigationView {
            SettingsSubgroupDetailsView(subgroup: .flow)
        }
        
        NavigationView {
            SettingsSubgroupDetailsView(subgroup: .pause)
        }
        
        NavigationView {
            SettingsSubgroupDetailsView(subgroup: .examples)
        }
    }
}
