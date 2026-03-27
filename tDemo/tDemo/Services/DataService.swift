import Foundation

class DataService {
    static let shared = DataService()
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"
    private let usersKey = "users"
    
    private init() {}
    
    func getCurrentUser() -> User {
        if let data = userDefaults.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        }
        
        // 创建默认用户数据
        let defaultUser = User(
            id: UUID(),
            name: "张三",
            avatar: "person.circle",
            followingCount: 120,
            followerCount: 356,
            likesCount: 1280,
            outfits: [
                Outfit(id: UUID(), imageURL: "photo", description: "今天的穿搭分享", likes: 45, timestamp: Date()),
                Outfit(id: UUID(), imageURL: "photo", description: "休闲风格", likes: 32, timestamp: Date().addingTimeInterval(-86400)),
                Outfit(id: UUID(), imageURL: "photo", description: "职场穿搭", likes: 56, timestamp: Date().addingTimeInterval(-172800))
            ]
        )
        
        saveCurrentUser(defaultUser)
        return defaultUser
    }
    
    func saveCurrentUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            userDefaults.set(data, forKey: userKey)
        }
    }
    
    func getUsers() -> [User] {
        if let data = userDefaults.data(forKey: usersKey),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        
        // 创建默认用户列表
        let defaultUsers = [
            User(
                id: UUID(),
                name: "李四",
                avatar: "person.circle",
                followingCount: 89,
                followerCount: 234,
                likesCount: 890,
                outfits: []
            ),
            User(
                id: UUID(),
                name: "王五",
                avatar: "person.circle",
                followingCount: 156,
                followerCount: 456,
                likesCount: 1560,
                outfits: []
            ),
            User(
                id: UUID(),
                name: "赵六",
                avatar: "person.circle",
                followingCount: 234,
                followerCount: 678,
                likesCount: 2340,
                outfits: []
            )
        ]
        
        saveUsers(defaultUsers)
        return defaultUsers
    }
    
    func saveUsers(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            userDefaults.set(data, forKey: usersKey)
        }
    }
}