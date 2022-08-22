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
    }
    
    func getSubgroupView(_ subgroup: SettingsSubGroup) -> AnyView {
        switch subgroup {
        case .tabata:
            return AnyView(TabataSettingsView())
        case .flow:
            return AnyView(FlowSettingsView())
        case .rest:
            return AnyView(RestSettingsView())
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
            SettingsSubgroupDetailsView(subgroup: .rest)
        }
        
        NavigationView {
            SettingsSubgroupDetailsView(subgroup: .examples)
        }
    }
}
