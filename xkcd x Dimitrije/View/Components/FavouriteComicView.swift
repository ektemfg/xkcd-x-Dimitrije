//
//  FavouriteComicView.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import SwiftUI

struct FavouriteComicView: View {
    @EnvironmentObject var vm: ViewModel
    let comic: Comic
    @State var isFavourite = false {
        didSet {
            vm.favCurrent()
        }
    }
    
    init(comic: Comic) {
        self.comic = comic
        self._isFavourite = State(initialValue: ViewModel.shared.currentComic?.liked ?? false)
    }
    
    var body: some View {
        VStack{
            VStack{
                Text(comic.title)
                Text("#" + String(comic.num))
            }
            Rectangle()
                .stroke()
                .frame(width: 400, height: 200)
                .overlay{
                    VStack{
                        HStack(alignment: .center){
                         Spacer()
                            Button(action: {
                                let itemsToShare : [Any] = [comic.title, comic.url]
                                vm.share(itemsToShare)
                            }, label: {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                    .padding()
                            })
                            AsyncImage(url: comic.url) { image in
                                image
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                  
                                
                            } placeholder: {
                                ProgressView()
                                Text("Loading comic...")
                                    .font(.system(.headline))
                            }
                            
                            
                            Button(action: {isFavourite.toggle()}, label: {
                                HStack{
                                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding()
                                        .foregroundColor(isFavourite ? .red : .black)
                                    
                                }})
                            Spacer()
                            
                        }
                       
                    }
                }
                .onReceive(vm.$currentComic) { comic in
                    isFavourite = comic?.liked ?? false
                }
            
        }
    }
}

struct FavouriteComicView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteComicView(comic: Comic(month: "Yes", num: 2239, link: "yes", year: "yes", news: "yes", safeTitle: "yes", transcript: "yes", alt: "yes", img: "https://imgs.xkcd.com/comics/helium_reserve_2x.png", title: "Helium Reserve", day: "yes"))
            .environmentObject(ViewModel.shared)
    }
}
