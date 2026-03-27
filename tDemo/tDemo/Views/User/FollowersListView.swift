import SwiftUI

struct FollowersListView: View {
    @ObservedObject var dataManager: LocalDataManager
    
    var body: some View {
        List {
            let followersUsers = dataManager.getFollowersUsers(for: dataManager.currentUser)
            
            if followersUsers.isEmpty {
                Text("还没有粉丝")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
            } else {
                ForEach(followersUsers) { user in
                    UserRowView(user: user)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("粉丝")
        .navigationBarTitleDisplayMode(.inline)
    }
}
