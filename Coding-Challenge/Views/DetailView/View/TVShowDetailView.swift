//
//  TVShowDetailView.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import SwiftUI

struct TVShowDetailView: View {
    
    @ObservedObject var viewModel = TVShowDetailViewModel()
    private var tvShow: TVShow
    
    init(tvShow: TVShow) {
        self.tvShow = tvShow
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                CustomAsyncImage(url: tvShow.backgroundURL, placeholder: {
                    Image("Primary Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.top)
                })
                
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
            VStack {
                ScrollView(.vertical) {
                    Spacer().frame(minHeight: 30)
                    
                    VStack(spacing: 20) {
                        TVShowSummaryView(title: tvShow.name, summary: tvShow.overview, creators: viewModel.tvShowCreators, voteAverage: tvShow.voteAverage)
                    
                        if !viewModel.tvShowSeasons.isEmpty {
                            TVShowLastSeasonView(seasons: viewModel.tvShowSeasons, posterURL: tvShow.backgroundURL)
                        }
                        
                        TVShowCastView(cast: viewModel.tvShowCast)
    
                    }
                    .background(Color("Secondary"))
                        
                }.frame(maxWidth: 330,maxHeight: 740, alignment: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

        }
        .frame(alignment: .bottom)
        .onAppear() {
            viewModel.getTVShowDetail(id: tvShow.id)
            viewModel.getTVShowCast(id: tvShow.id)
        }
        .background(Color("Almost Black"))
        .edgesIgnoringSafeArea(.bottom)

    }
}

struct TVShowDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        TVShowDetailView(tvShow: TVShow(id: 1, backgroundPath: "", voteAverage: 8.0, overview: "Rick is a mentally-unbalanced but scientifically-gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.", name: "Rick and Morty", firstAirDate: "2000-10-10"))
    }
}
