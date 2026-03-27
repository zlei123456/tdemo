//
//  User.swift
//  tDemo
//
//  Created by AI Assistant on 2026/3/27.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    var nickname: String
    var avatarURL: String?
    var followingCount: Int
    var followersCount: Int
    var likesCount: Int
    var bio: String?
    var isFollowing: Bool
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

struct Post: Identifiable, Codable {
    let id: String
    let userId: String
    var imageURLs: [String]
    var description: String
    var likesCount: Int
    var createdAt: Date
}
