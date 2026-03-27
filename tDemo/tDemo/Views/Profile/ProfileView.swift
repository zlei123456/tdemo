//
//  ProfileView.swift
//  tDemo
//
//  Created by AI Assistant on 2026/3/27.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 用户信息区域
                ProfileHeaderView(user: dataManager.currentUser)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                // 统计数字区域
                ProfileStatsView(user: dataManager.currentUser)
                    .padding(.vertical, 20)
                
                Divider()
                
                // 穿搭内容列表
                ProfilePostsView(posts: dataManager.getCurrentUserPosts())
            }
        }
        .navigationTitle("个人主页")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 头像和基本信息
struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 20) {
            // 头像
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                
                if let avatarURL = user.avatarURL {
                    // 如果有头像URL，显示图片
                    AsyncImage(url: URL(string: avatarURL)) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                } else {
                    // 默认头像
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                }
            }
            
            // 昵称和简介
            VStack(alignment: .leading, spacing: 8) {
                Text(user.nickname)
                    .font(.title2)
                    .fontWeight(.bold)
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
            
            Spacer()
        }
    }
}

// 统计数字区域
struct ProfileStatsView: View {
    let user: User
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        HStack(spacing: 0) {
            // 关注数
            NavigationLink(destination: FollowingListView()) {
                StatItemView(count: user.followingCount, title: "关注")
            }
            
            Divider()
                .frame(height: 30)
            
            // 粉丝数
            NavigationLink(destination: FollowersListView()) {
                StatItemView(count: user.followersCount, title: "粉丝")
            }
            
            Divider()
                .frame(height: 30)
            
            // 获赞数
            StatItemView(count: user.likesCount, title: "获赞")
        }
    }
}

// 统计项视图
struct StatItemView: View {
    let count: Int
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

// 穿搭内容列表
struct ProfilePostsView: View {
    let posts: [Post]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("穿搭分享")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 10)
            
            if posts.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "tshirt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("还没有分享穿搭")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, minHeight: 200)
            } else {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(posts) { post in
                        PostGridItemView(post: post)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }
}

// 穿搭网格项
struct PostGridItemView: View {
    let post: Post
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(1, contentMode: .fill)
            
            if let firstImage = post.imageURLs.first {
                // 显示图片
                AsyncImage(url: URL(string: firstImage)) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
            } else {
                // 默认图标
                VStack(spacing: 4) {
                    Image(systemName: "tshirt.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text(post.description)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .padding(.horizontal, 4)
                }
            }
            
            // 点赞数覆盖层
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.caption2)
                        .foregroundColor(.white)
                    Text("\(post.likesCount)")
                        .font(.caption2)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(6)
                .background(Color.black.opacity(0.3))
            }
        }
        .clipped()
    }
}

#Preview {
    NavigationView {
        ProfileView()
            .environmentObject(DataManager.shared)
    }
}
