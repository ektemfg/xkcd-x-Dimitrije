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
    
    var body: some View {
        let comicShowing = vm.currentComic
        GeometryReader { screen in
            VStack {
                HStack{
                    Spacer()
                    AsyncImage(url: comicShowing?.url) { image in
                        image
                            .resizable()
                            .frame(width: screen.size.width, height: screen.size.height * 0.7)
                    } placeholder: {
                        ProgressView()
                        Text("Loading comic...")
                    }
                    Spacer()
                }
            }
            
            .navigationBarItems(leading: Text(comicShowing?.title ?? "Comic"), trailing: HStack{
                Text("Next")
                    .foregroundColor(.black)
                Image(systemName: "arrow.forward")
            }.onTapGesture {
                vm.getRandom()
            }
                                
            )
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
