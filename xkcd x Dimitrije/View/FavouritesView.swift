//
//  FavouritesView.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        if vm.favouriteComics.isEmpty {
            VStack{
                Divider()
                Spacer()
                HStack(spacing:0) {
                    Text("Nothing here!")
                        .font(.system(.title))
                }
                Image("xkcd")
                    .resizable()
                    .frame(width: 250, height: 250)
                HStack(spacing:0){
                    Text("Click")
                        .font(.system(.title2))
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("on a comic!")
                        .font(.system(.title2))
                }
                Spacer()
            }
            .navigationTitle(
                Text("No Favourites")
            )
            .navigationBarTitleDisplayMode(.inline)
        } else {
          
                List(vm.favouriteComics, id: \.num) { comic in
                    VStack{
                        FavouriteComicView(comic: comic)
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
             .navigationTitle(
                Text("Your Favourites")
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
