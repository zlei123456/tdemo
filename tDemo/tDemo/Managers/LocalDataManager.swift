import Foundation
import Combine

class LocalDataManager: ObservableObject {
    static let shared = LocalDataManager()
    
    @Published var currentUser: User
    @Published var users: [User] = []
    @Published var outfits: [Outfit] = []
    
    private let usersKey = "users"
    private let outfitsKey = "outfits"
    private let currentUserKey = "currentUser"
    
    private init() {
        currentUser = User(
            nickname: "时尚达人",
            avatarURL: nil,
            followingCount: 128,
            followersCount: 256,
            likesCount: 1024,
            outfitIds: []
        )
        loadMockData()
    }
    
    private func loadMockData() {
        let user1 = User(
            id: UUID(),
            nickname: "潮流小王子",
            avatarURL: nil,
            followingCount: 50,
            followersCount: 120,
            likesCount: 300,
            outfitIds: []
        )
        let user2 = User(
            id: UUID(),
            nickname: "穿搭女神",
            avatarURL: nil,
            followingCount: 80,
            followersCount: 500,
            likesCount: 2000,
            outfitIds: []
        )
        let user3 = User(
            id: UUID(),
            nickname: "时尚博主",
            avatarURL: nil,
            followingCount: 30,
            followersCount: 800,
            likesCount: 5000,
            outfitIds: []
        )
        let user4 = User(
            id: UUID(),
            nickname: "街拍达人",
            avatarURL: nil,
            followingCount: 100,
            followersCount: 300,
            likesCount: 800,
            outfitIds: []
        )
        let user5 = User(
            id: UUID(),
            nickname: "搭配师",
            avatarURL: nil,
            followingCount: 20,
            followersCount: 1000,
            likesCount: 8000,
            outfitIds: []
        )
        
        users = [user1, user2, user3, user4, user5]
        
        let outfit1 = Outfit(
            userId: currentUser.id,
            imageURL: "outfit1",
            title: "春季简约穿搭",
            likesCount: 128,
            createDate: Date()
        )
        let outfit2 = Outfit(
            userId: currentUser.id,
            imageURL: "outfit2",
            title: "夏日清凉搭配",
            likesCount: 256,
            createDate: Date().addingTimeInterval(-86400)
        )
        let outfit3 = Outfit(
            userId: currentUser.id,
            imageURL: "outfit3",
            title: "秋冬复古风",
            likesCount: 512,
            createDate: Date().addingTimeInterval(-172800)
        )
        let outfit4 = Outfit(
            userId: currentUser.id,
            imageURL: "outfit4",
            title: "职场正装",
            likesCount: 64,
            createDate: Date().addingTimeInterval(-259200)
        )
        
        outfits = [outfit1, outfit2, outfit3, outfit4]
    }
    
    func getUserOutfits(for user: User) -> [Outfit] {
        return outfits.filter { $0.userId == user.id }
    }
    
    func getFollowingUsers(for user: User) -> [User] {
        return Array(users.prefix(3))
    }
    
    func getFollowersUsers(for user: User) -> [User] {
        return Array(users.suffix(3))
    }
}
