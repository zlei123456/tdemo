import SwiftUI

struct ProfileView: View {
    @State private var user = DataService.shared.getCurrentUser()
    private let users = DataService.shared.getUsers()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // User Info Section
                HStack(alignment: .top) {
                    Image(systemName: user.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(user.name)
                            .font(.headline)
                        
                        HStack(spacing: 16) {
                            NavigationLink(destination: UserListView(title: "关注列表", users: users)) {
                                VStack(alignment: .center) {
                                    Text("\(user.followingCount)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Text("关注")
                                        .font(.caption)
                                }
                            }
                            
                            NavigationLink(destination: UserListView(title: "粉丝列表", users: users)) {
                                VStack(alignment: .center) {
                                    Text("\(user.followerCount)")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Text("粉丝")
                                        .font(.caption)
                                }
                            }
                            
                            VStack(alignment: .center) {
                                Text("\(user.likesCount)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("获赞")
                                    .font(.caption)
                            }
                        }
                    }
                }
                .padding()
                
                // Outfits Section
                Text("我的穿搭")
                    .font(.headline)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 4) {
                    ForEach(user.outfits) { outfit in
                        VStack {
                            Image(systemName: outfit.imageURL)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width / 3 - 4, height: UIScreen.main.bounds.width / 3 - 4)
                                .clipped()
                            Text("\(outfit.likes) 赞")
                                .font(.caption)
                                .padding(.top, 4)
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .navigationTitle("个人主页")
        .navigationBarTitleDisplayMode(.inline)
    }
}