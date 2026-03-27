import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var avatar: String
    var followingCount: Int
    var followerCount: Int
    var likesCount: Int
    var outfits: [Outfit]
}

struct Outfit: Identifiable, Codable {
    let id: UUID
    var imageURL: String
    var description: String
    var likes: Int
    var timestamp: Date
}