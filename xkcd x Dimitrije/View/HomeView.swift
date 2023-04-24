//
//  HomeView.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//  This will be the main view in the app.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: ViewModel
    @State var isFavourite = false
    
    var body: some View {
        let comicShowing = vm.currentComic
            VStack {
                Text(comicShowing?.title ?? "Comic")
                    .font(.system(.headline))
                    .padding(.bottom, 10)
                HStack{
                    Spacer()
                    AsyncImage(url: comicShowing?.url) { image in
                        image
                            .resizable()
                        
                    } placeholder: {
                        ProgressView()
                        Text("Loading comic...")
                            .font(.system(.headline))
                    }
                    Spacer()
                }
                HStack{
                    Spacer()
                    Button(action: {isFavourite.toggle()}, label: {
                        HStack{
                            Image(systemName: isFavourite ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isFavourite ? .red : .black)
                            
                        }})
                    Spacer()
                    Button(action: {
                        let titleToShare = comicShowing?.title
                        let linkToShare = comicShowing?.url
                        guard (titleToShare != nil), linkToShare != nil else {
                            Logger.log("Could not create share sheet.", reason: .warning)
                        return
                        }
                        let itemsToShare : [Any] = [titleToShare, linkToShare]
                        vm.share(itemsToShare)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    })
                    Spacer()
                    
                }
                .padding(.bottom, 20)
            }
            
            
            .navigationBarItems(leading: Text("Comic Number: \(comicShowing?.num ?? 0)")
                .font(.system(.headline))
                                , trailing: HStack{
                Text("Next")
                    .font(.system(.headline))
                    .foregroundColor(.black)
                Image(systemName: "arrow.forward")
            }.onTapGesture {
                vm.getRandom()
            }
                                
            )
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
