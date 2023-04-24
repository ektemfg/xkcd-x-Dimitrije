//
//  FavouriteComicView.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import SwiftUI

    struct FavouriteComicView: View {
        let comic: Comic
        @EnvironmentObject var vm: ViewModel
        @State var isFavourite = false
        
        var body: some View {
            NavigationLink("",
                           destination: ComicDetailView(comic: comic)).opacity(0)
            .buttonStyle(PlainButtonStyle())
            VStack{
                VStack{
                    Text(comic.title)
                    Text("#" + String(comic.num))
                }
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 400, height: 200)
                    .overlay{
                        VStack{
                            HStack(alignment: .center){
                            
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 50)
                                    .onTapGesture {
                                        let itemsToShare : [Any] = [comic.title, comic.url]
                                        vm.share(itemsToShare)
                                    }
                                AsyncImage(url: comic.url) { image in
                                    image
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                      
                                    
                                } placeholder: {
                                    ProgressView()
                                    Text("Loading comic...")
                                        .font(.system(.headline))
                                }
                                
                                
                                HStack{
                                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.horizontal, 50)
                                        .foregroundColor(isFavourite ? .red : .black)
                                    
                                }.onTapGesture {
                                    isFavourite.toggle()
                                    vm.favOrRemove(comic: comic)
                                }
                               
                                
                            }
                           
                        }
                    }
                    .onReceive(vm.$favouriteComics) { favouriteComics in
                        isFavourite = favouriteComics.contains { $0.num == comic.num }
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
