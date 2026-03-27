import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "person.fill")
                    .font(.title3)
                    .foregroundStyle(.gray)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.nickname)
                    .font(.headline)
                
                HStack(spacing: 16) {
                    Text("关注 \(user.followingCount)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("粉丝 \(user.followersCount)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
