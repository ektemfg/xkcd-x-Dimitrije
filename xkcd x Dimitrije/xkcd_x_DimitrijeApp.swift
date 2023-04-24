//
//  xkcd_x_DimitrijeApp.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import SwiftUI
import UIKit

@main
struct xkcd_x_DimitrijeApp: App {
    @StateObject private var vm = ViewModel.shared
    @State private var selectedTab = 1
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
    }
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    NavigationView {
                        SearchView()
                    }
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(0)
                    
                    NavigationView {
                        HomeView()
                    }
                    .tabItem {
                        Label("Comics", systemImage: "face.smiling")
                    }
                    .tag(1)
                    
                    NavigationView {
                        FavouritesView()
                    }
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
                    .tag(2)
                }
                .environmentObject(vm)
                .edgesIgnoringSafeArea(.bottom)
                
                Divider()
                    .background(Color.gray)
                    .frame(height: 1)
                    .offset(y: -49)
                    .padding(.bottom, 1)
                
            }
        }
    }
}
