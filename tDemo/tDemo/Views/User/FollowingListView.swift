import SwiftUI

struct FollowingListView: View {
    @ObservedObject var dataManager: LocalDataManager
    
    var body: some View {
        List {
            let followingUsers = dataManager.getFollowingUsers(for: dataManager.currentUser)
            
            if followingUsers.isEmpty {
                Text("还没有关注任何人")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
            } else {
                ForEach(followingUsers) { user in
                    UserRowView(user: user)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("关注")
        .navigationBarTitleDisplayMode(.inline)
    }
}
