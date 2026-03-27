//
//  FollowersListView.swift
//  tDemo
//
//  Created by AI Assistant on 2026/3/27.
//

import SwiftUI

struct FollowersListView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        List {
            ForEach(dataManager.getFollowersList()) { user in
                UserListItemView(user: user)
            }
        }
        .listStyle(.plain)
        .navigationTitle("粉丝列表")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        FollowersListView()
            .environmentObject(DataManager.shared)
    }
}
