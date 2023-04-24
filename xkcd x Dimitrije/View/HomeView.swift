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
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack {
            Text(vm.currentComic?.title ?? "Comic")
                .font(.system(.headline))
                .padding(.bottom, 10)
            HStack{
                Spacer()
                AsyncImage(url: vm.currentComic?.url) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                    Text("Loading comic...")
                        .font(.system(.headline))
                }
                Spacer()
            }
            VStack{
                Divider()
            HStack{
                Spacer()
                Button(action: {
                    vm.favOrRemove(comic: nil)
                    isFavourite = vm.favouriteComics.contains { $0.num == vm.currentComic?.num }
                }, label: {
                    HStack{
                        VStack{
                            Image(systemName: vm.currentComic?.liked ?? false ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(isFavourite ? .red : .black)
                            Text("Like")
                        }
                        
                    }
                })
                Spacer()
                Button(action: {
                    let titleToShare = vm.currentComic?.title
                    let linkToShare = vm.currentComic?.url
                    guard (titleToShare != nil), linkToShare != nil else {
                        Logger.log("Could not create share sheet.", reason: .warning)
                        return
                    }
                    let itemsToShare : [Any] = [titleToShare!, linkToShare!]
                    vm.share(itemsToShare)
                }, label: {
                    VStack{
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                        Text("Share")
                    }
                })
                Spacer()
                
            }
        }
            
            .padding(.bottom, 10)
        }
        .offset(offset)
                    .animation(.easeInOut(duration: 0.3))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let offsetWidth = offset.width + gesture.translation.width
                                if offsetWidth >= -UIScreen.main.bounds.width && offsetWidth <= UIScreen.main.bounds.width {
                                    self.offset = gesture.translation
                                }
                            }
                            .onEnded { gesture in
                                let offsetWidth = offset.width + gesture.translation.width
                                if offsetWidth < -50 {
                                    withAnimation {
                                        self.offset = CGSize(width: -UIScreen.main.bounds.width, height: 0)
                                    }
                                    vm.getSpecific(number: vm.currentComic!.num + 1)
                                    withAnimation {
                                        self.offset = .zero
                                    }
                                } else if offsetWidth > 50 {
                                    withAnimation {
                                        self.offset = CGSize(width: UIScreen.main.bounds.width, height: 0)
                                    }
                                    vm.getSpecific(number: vm.currentComic!.num - 1)
                                    withAnimation {
                                        self.offset = .zero
                                    }
                                } else {
                                    withAnimation {
                                        self.offset = .zero
                                    }
                                
                                }
                            }
                        )
        
        
        .navigationBarItems(leading:
                                HStack(alignment: .center, spacing:20){
            Image(systemName: "arrow.backward")
            Text("Previous")
                .font(.system(.headline))
                .foregroundColor(.black)
            Text("Comic #\(vm.currentComic?.num ?? 0)")
                .font(.system(.headline))
        }
            .onTapGesture {
                vm.getSpecific(number: vm.currentComic!.num - 1)
            }
                            , trailing: HStack{
            Text("Random")
                .font(.system(.headline))
                .foregroundColor(.black)
            Image(systemName: "arrow.counterclockwise")
        }.onTapGesture {
            vm.getRandom()
        }
                            
        ) .onReceive(vm.$currentComic) { comic in
            self.isFavourite = vm.favouriteComics.contains { $0.num == comic?.num }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
