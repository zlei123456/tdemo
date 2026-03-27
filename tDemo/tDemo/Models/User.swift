import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: UUID
    var nickname: String
    var avatarURL: String?
    var followingCount: Int
    var followersCount: Int
    var likesCount: Int
    var outfitIds: [UUID]
    
    init(
        id: UUID = UUID(),
        nickname: String,
        avatarURL: String? = nil,
        followingCount: Int = 0,
        followersCount: Int = 0,
        likesCount: Int = 0,
        outfitIds: [UUID] = []
    ) {
        self.id = id
        self.nickname = nickname
        self.avatarURL = avatarURL
        self.followingCount = followingCount
        self.followersCount = followersCount
        self.likesCount = likesCount
        self.outfitIds = outfitIds
    }
}

struct Outfit: Identifiable, Codable, Equatable {
    let id: UUID
    var userId: UUID
    var imageURL: String
    var title: String
    var likesCount: Int
    var createDate: Date
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        imageURL: String,
        title: String,
        likesCount: Int = 0,
        createDate: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.imageURL = imageURL
        self.title = title
        self.likesCount = likesCount
        self.createDate = createDate
    }
}
