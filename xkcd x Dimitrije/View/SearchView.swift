//
//  SearchView.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    @State private var isWebPresented = false
    var body: some View {
        GeometryReader { screen in
            VStack{
                HStack{
                    Spacer()
                    Image("xkcd")
                        .resizable()
                        .frame(width: screen.size.width * 0.5, height: 250)
                    Spacer()
                }
                Text("❓🤔❓")
                    .font(.system(size: 60))
                Image(systemName: "arrow.down")
                    .font(.title)
                    .padding(.bottom, 10)
                HStack {
                    
                  Spacer()
                    TextField("What are you looking for?", text: $query)
                        .font(.system(.title3))
                           .padding(.horizontal, 20)
                           .padding(.vertical, 10)
                           .overlay(
                               RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.gray, lineWidth: 1)
                           )
                           .foregroundColor(.gray)
                           
                    Spacer()
                 
                }
                Button(action: {
                    isWebPresented = true
                }) {
                    Text("Search")
                        .font(.system(.title2))
                }
                .padding([.bottom, .top], 20)
                
                .buttonStyle(.bordered)
                Text("Is relevant-xkcd offline?")
                    .font(.system(.headline))
                Button(action: {
                                       let baseURLString = "https://www.google.com/search?q="
                                       let searchString = "\"\(query)\" site:xkcd.com"
                                       let encodedString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                       let urlString = baseURLString + encodedString
                                       if let searchURL = URL(string: urlString) {
                                           UIApplication.shared.open(searchURL)
                                       }
                                   }) {
                                       Text("Google Search")
                                           .font(.system(.title2))
                                   }
                                   
                                   .buttonStyle(.bordered)
                   
            }
            .padding(.top, screen.size.height * 0.10)
            
        }
        .sheet(isPresented: $isWebPresented) {
                    NavigationStack {
                        WebView(url: URL(string: "https://relevant-xkcd.github.io/?q=" + query)!)
                            .ignoresSafeArea()
                            .navigationTitle("xkcd Search")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
    }
       
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
