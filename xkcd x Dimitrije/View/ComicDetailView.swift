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
                            .aspectRatio(contentMode: .fit)
                            .accessibility(hidden: false)
                            .accessibility(label: Text(comic.transcript))
                        
                    } placeholder: {
                        ProgressView()
                        Text("Loading comic...")
                            .font(.system(.headline))
                    }
                 
                    VStack(spacing: 8){
                        Text("Comic Date:")
                            .font(.system(.title2))
                        if let dateText = comic.dateText {
                            Text("Published at \(dateText)")
                        } else {
                            Text("Somewhere between 01/01/2006 and \(vm.todayDateText())")
                                .font(.system(.title3))
                        }
                        Text("Comic Description:")
                            .font(.system(.title2))
                            .lineLimit(10)
                        Text(comic.alt)
                            .font(.system(.title3))
                        Text("Link:")
                            .font(.system(.title2))
                        HStack{
                            Text("TAP ON ME")
                                .font(.system(.title3))
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    Logger.log("Opening comic in browser", reason: .info)
                                    openURL(comic.url!)
                                }
                        }
                        Text("Share with friends")
                        HStack{
                           Button(action: {
                               let itemsToShare : [Any] = [comic.title, comic.url!]
                               vm.share(itemsToShare)
                           }, label: {
                               Image(systemName: "square.and.arrow.up")
                                   .resizable()
                                   .frame(width: 30, height: 35)
                                   .foregroundColor(.blue)
                           })
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
