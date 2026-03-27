import SwiftUI

struct UserListView: View {
    let title: String
    let users: [User]
    
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
                    
                    Button(action: {}) {
                        Text("关注")
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color.blue)
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
}