//
//  FollowingListView.swift
//  tDemo
//
//  Created by AI Assistant on 2026/3/27.
//

import SwiftUI

struct FollowingListView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        List {
            ForEach(dataManager.getFollowingList()) { user in
                UserListItemView(user: user)
            }
        }
        .listStyle(.plain)
        .navigationTitle("关注列表")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 用户列表项视图（共用组件）
struct UserListItemView: View {
    let user: User
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        HStack(spacing: 12) {
            // 头像
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                
                if let avatarURL = user.avatarURL {
                    AsyncImage(url: URL(string: avatarURL)) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                }
            }
            
            // 用户信息
            VStack(alignment: .leading, spacing: 4) {
                Text(user.nickname)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                HStack(spacing: 8) {
                    Text("关注 \(user.followingCount)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("粉丝 \(user.followersCount)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // 关注/取消关注按钮
            if user.id != dataManager.currentUser.id {
                FollowButton(user: user)
            }
        }
        .padding(.vertical, 4)
    }
}

// 关注按钮
struct FollowButton: View {
    let user: User
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        Button(action: {
            dataManager.toggleFollow(userId: user.id)
        }) {
            Text(user.isFollowing ? "已关注" : "关注")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(user.isFollowing ? .gray : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(user.isFollowing ? Color.gray.opacity(0.2) : Color.blue)
                .cornerRadius(4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationView {
        FollowingListView()
            .environmentObject(DataManager.shared)
    }
}
