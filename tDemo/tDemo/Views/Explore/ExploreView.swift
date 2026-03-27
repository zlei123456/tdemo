//
//  ExploreView.swift
//  tDemo
//
//  Created by AI Assistant on 2026/3/27.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var dataManager = DataManager.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 探索页面内容区域
                    ExploreContentView()
                }
            }
            .navigationTitle("探索")
            .toolbar {
                // 右上角个人主页入口
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        HStack(spacing: 4) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 18))
                            Text("个人主页")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
        }
        .environmentObject(dataManager)
    }
}

// 探索页面内容
struct ExploreContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // 推荐穿搭区域
            RecommendedSection()
            
            // 热门话题区域
            TrendingTopicsSection()
            
            // 精选用户区域
            FeaturedUsersSection()
        }
        .padding(.vertical)
    }
}

// 推荐穿搭区域
struct RecommendedSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("推荐穿搭")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("查看更多") {
                    // TODO: 查看更多推荐
                }
                .font(.caption)
                .foregroundColor(.blue)
            }
            .padding(.horizontal)
            
            // 横向滚动的推荐内容
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<5) { index in
                        RecommendedOutfitCard(index: index)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// 推荐穿搭卡片
struct RecommendedOutfitCard: View {
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 图片占位
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 200)
                .overlay(
                    Image(systemName: "tshirt.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray.opacity(0.5))
                )
            
            Text("穿搭分享 #\(index + 1)")
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack {
                Image(systemName: "heart.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                Text("\(100 + index * 23)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 150)
    }
}

// 热门话题区域
struct TrendingTopicsSection: View {
    let topics = ["#春日穿搭", "#街头风", "#职场穿搭", "#复古风", "#简约主义", "#运动风"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("热门话题")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            FlowLayout(spacing: 8) {
                ForEach(topics, id: \.self) { topic in
                    TopicTag(title: topic)
                }
            }
            .padding(.horizontal)
        }
    }
}

// 话题标签
struct TopicTag: View {
    let title: String
    
    var body: some View {
        Button(action: {
            // TODO: 点击话题
        }) {
            Text(title)
                .font(.system(size: 14))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// 精选用户区域
struct FeaturedUsersSection: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("精选用户")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                ForEach(dataManager.users.prefix(3)) { user in
                    UserListItemView(user: user)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    
                    if user.id != dataManager.users.prefix(3).last?.id {
                        Divider()
                            .padding(.leading, 70)
                    }
                }
            }
            .background(Color(.systemBackground))
        }
    }
}

// 流式布局辅助视图
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                      y: bounds.minY + result.positions[index].y),
                         proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var positions: [CGPoint] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var rowHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += rowHeight + spacing
                    rowHeight = 0
                }
                
                positions.append(CGPoint(x: x, y: y))
                rowHeight = max(rowHeight, size.height)
                x += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: y + rowHeight)
        }
    }
}

#Preview {
    ExploreView()
}
