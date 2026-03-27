import SwiftUI

struct ProfileView: View {
    @ObservedObject var dataManager: LocalDataManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                avatarSection
                userInfoSection
                statsSection
                outfitSection
            }
            .padding()
        }
        .navigationTitle("个人主页")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var avatarSection: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 100)
            
            Image(systemName: "person.fill")
                .font(.system(size: 50))
                .foregroundStyle(.gray)
        }
    }
    
    private var userInfoSection: some View {
        Text(dataManager.currentUser.nickname)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    private var statsSection: some View {
        HStack(spacing: 40) {
            NavigationLink(destination: FollowingListView(dataManager: dataManager)) {
                VStack(spacing: 4) {
                    Text("\(dataManager.currentUser.followingCount)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("关注")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            NavigationLink(destination: FollowersListView(dataManager: dataManager)) {
                VStack(spacing: 4) {
                    Text("\(dataManager.currentUser.followersCount)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("粉丝")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            VStack(spacing: 4) {
                Text("\(dataManager.currentUser.likesCount)")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("赞")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var outfitSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("我的穿搭")
                .font(.headline)
                .padding(.horizontal)
            
            let userOutfits = dataManager.getUserOutfits(for: dataManager.currentUser)
            
            if userOutfits.isEmpty {
                Text("还没有分享穿搭")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ], spacing: 8) {
                    ForEach(userOutfits) { outfit in
                        OutfitCardView(outfit: outfit)
                    }
                }
            }
        }
    }
}

struct OutfitCardView: View {
    let outfit: Outfit
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1, contentMode: .fit)
                
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
            
            Text(outfit.title)
                .font(.caption)
                .lineLimit(1)
            
            HStack(spacing: 4) {
                Image(systemName: "heart.fill")
                    .font(.caption2)
                Text("\(outfit.likesCount)")
                    .font(.caption2)
            }
            .foregroundStyle(.red)
        }
    }
}
