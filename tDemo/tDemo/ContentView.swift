import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = LocalDataManager.shared
    
    var body: some View {
        NavigationStack {
            ExploreView(dataManager: dataManager)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: ProfileView(dataManager: dataManager)) {
                            HStack(spacing: 4) {
                                Image(systemName: "person.circle.fill")
                                Text("个人主页")
                            }
                        }
                    }
                }
        }
    }
}

struct ExploreView: View {
    @ObservedObject var dataManager: LocalDataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("今日推荐")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ], spacing: 8) {
                    ForEach(dataManager.outfits) { outfit in
                        VStack(spacing: 4) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .aspectRatio(1, contentMode: .fit)
                                
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.gray)
                            }
                            
                            HStack {
                                Text(outfit.title)
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                HStack(spacing: 2) {
                                    Image(systemName: "heart.fill")
                                        .font(.caption2)
                                    Text("\(outfit.likesCount)")
                                        .font(.caption2)
                                }
                                .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("探索")
    }
}

@MainActor
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
