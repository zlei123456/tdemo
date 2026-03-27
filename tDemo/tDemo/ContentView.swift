//
//  ContentView.swift
//  tDemo
//
//  Created by lei on 2026/3/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager.shared
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 首页/探索页面
            ExploreView()
                .tabItem {
                    Image(systemName: "compass")
                    Text("探索")
                }
                .tag(0)
            
            // 发布页面
            Text("发布")
                .tabItem {
                    Image(systemName: "plus.square")
                    Text("发布")
                }
                .tag(1)
            
            // 消息页面
            Text("消息")
                .tabItem {
                    Image(systemName: "message")
                    Text("消息")
                }
                .tag(2)
            
            // 我的页面（个人主页）
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("我的")
                }
                .tag(3)
        }
        .environmentObject(dataManager)
    }
}

#Preview {
    ContentView()
}
