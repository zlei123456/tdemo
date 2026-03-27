import SwiftUI

struct UserListView: View {
    let title: String
    let users: [User]
    @State private var followingUsers: Set<UUID> = []
    
    var body: some View {
        List {
            ForEach(users) { user in
                HStack(alignment: .center) {
                    Image(systemName: user.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        HStack(spacing: 12) {
                            Text("关注: \(user.followingCount)")
                                .font(.caption)
                            Text("粉丝: \(user.followerCount)")
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        toggleFollow(user)
                    }) {
                        Text(followingUsers.contains(user.id) ? "已关注" : "关注")
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(followingUsers.contains(user.id) ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleFollow(_ user: User) {
        if followingUsers.contains(user.id) {
            followingUsers.remove(user.id)
        } else {
            followingUsers.insert(user.id)
        }
    }
}