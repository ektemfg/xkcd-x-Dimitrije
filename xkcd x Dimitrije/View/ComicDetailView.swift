//
//  ComicDetailView.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import SwiftUI

struct ComicDetailView: View {
    let comic: Comic
    @EnvironmentObject var vm: ViewModel
    @Environment(\.openURL) private var openURL
    var body: some View {
        GeometryReader { screen in
            ScrollView{
                VStack(alignment: .center){
                    AsyncImage(url: comic.url) { image in
                        image
                            .resizable()
                            .frame(width: screen.size.width * 0.90, height: screen.size.height * 0.75)
                        
                        
                    } placeholder: {
                        ProgressView()
                        Text("Loading comic...")
                            .font(.system(.headline))
                    }
                    VStack(spacing: 8){
                        Text("Comic Date:")
                            .font(.system(.title2))
                        Text("Somewhere between 05/09/2005 and \(vm.todayDateText())")
                            .font(.system(.title3))
                        Text("Comic Description:")
                            .font(.system(.title2))
                            .lineLimit(10)
                        Text(comic.alt)
                            .font(.system(.title3))
                        Text("Link:")
                            .font(.system(.title2))
                        Text("TAP ON ME")
                            .font(.system(.title3))
                            .onTapGesture {
                            Logger.log("Opening comic in browser", reason: .info)
                            openURL(URL(string: comic.link)!)
                        }
                    }
                 
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            
        }
    }
    
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailView(comic: Comic(month: "Yes", num: 2239, link: "yes", year: "yes", news: "yes", safeTitle: "yes", transcript: "yes", alt: "yes", img: "https://imgs.xkcd.com/comics/helium_reserve_2x.png", title: "Helium Reserve", day: "yes"))
            .environmentObject(ViewModel.shared)
    }
}
