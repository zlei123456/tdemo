//
//  DataManager.swift
//  tDemo
//
//  Created by AI Assistant on 2026/3/27.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var currentUser: User
    @Published var posts: [Post]
    @Published var users: [User]
    
    private init() {
        // 初始化模拟数据
        self.currentUser = User(
            id: "user_001",
            nickname: "时尚达人",
            avatarURL: nil,
            followingCount: 128,
            followersCount: 256,
            likesCount: 1024,
            bio: "热爱穿搭，分享日常",
            isFollowing: false
        )
        
        self.users = [
            User(id: "user_002", nickname: "潮流小王子", avatarURL: nil, followingCount: 56, followersCount: 89, likesCount: 234, bio: "街头风格", isFollowing: true),
            User(id: "user_003", nickname: "优雅女士", avatarURL: nil, followingCount: 234, followersCount: 567, likesCount: 890, bio: "优雅永不过时", isFollowing: false),
            User(id: "user_004", nickname: "运动达人", avatarURL: nil, followingCount: 78, followersCount: 123, likesCount: 456, bio: "运动风穿搭", isFollowing: true),
            User(id: "user_005", nickname: "复古爱好者", avatarURL: nil, followingCount: 45, followersCount: 67, likesCount: 123, bio: "复古风格", isFollowing: false),
            User(id: "user_006", nickname: "简约主义", avatarURL: nil, followingCount: 89, followersCount: 156, likesCount: 345, bio: "少即是多", isFollowing: true),
        ]
        
        self.posts = [
            Post(id: "post_001", userId: "user_001", imageURLs: [], description: "今日穿搭分享，简约风格~", likesCount: 45, createdAt: Date()),
            Post(id: "post_002", userId: "user_001", imageURLs: [], description: "周末出街look", likesCount: 67, createdAt: Date().addingTimeInterval(-86400)),
            Post(id: "post_003", userId: "user_001", imageURLs: [], description: "新入手的单品", likesCount: 89, createdAt: Date().addingTimeInterval(-172800)),
            Post(id: "post_004", userId: "user_001", imageURLs: [], description: "通勤穿搭", likesCount: 34, createdAt: Date().addingTimeInterval(-259200)),
        ]
    }
    
    // 获取当前用户的穿搭列表
    func getCurrentUserPosts() -> [Post] {
        return posts.filter { $0.userId == currentUser.id }
    }
    
    // 获取关注列表
    func getFollowingList() -> [User] {
        // 返回已关注的用户
        return users.filter { $0.isFollowing }
    }
    
    // 获取粉丝列表
    func getFollowersList() -> [User] {
        // 模拟粉丝数据（返回部分用户作为粉丝）
        return Array(users.prefix(3))
    }
    
    // 切换关注状态
    func toggleFollow(userId: String) {
        if let index = users.firstIndex(where: { $0.id == userId }) {
            users[index].isFollowing.toggle()
            // 更新关注数
            if users[index].isFollowing {
                currentUser.followingCount += 1
            } else {
                currentUser.followingCount -= 1
            }
        }
    }
    
    // 从服务器获取用户数据（预留接口）
    func fetchUserFromServer(userId: String, completion: @escaping (User?) -> Void) {
        // TODO: 实现网络请求
        completion(nil)
    }
    
    // 从服务器获取用户帖子（预留接口）
    func fetchUserPostsFromServer(userId: String, completion: @escaping ([Post]) -> Void) {
        // TODO: 实现网络请求
        completion([])
    }
}
