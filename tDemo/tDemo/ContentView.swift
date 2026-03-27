//
//  ContentView.swift
//  tDemo
//
//  Created by lei on 2026/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("探索页面")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("发现更多穿搭灵感")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .navigationTitle("探索")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Text("个人主页")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
