//
//  TVShowCellView.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import SwiftUI

struct TVShowCellView: View {
    let tvShow: TVShow
    
    var body: some View {
        VStack(spacing: 15) {
            
            CustomAsyncImage(url: URL(string: tvShow.backgroundPath), placeholder: {
                Image("Primary Image")
            })
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            VStack {
                Text(tvShow.name)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Primary"))
                
                Spacer()
                    .frame(minHeight: 11, maxHeight: 15)
                
                HStack(spacing: 80) {
                    Text(tvShow.firstAirDate)
                        .foregroundColor(Color("Primary"))
                    
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("Primary"))
                        Text(String(format: "%.2f", tvShow.voteAverage))
                            .foregroundColor(Color("Primary"))
                    }
                }
                
                Spacer()
                    .frame(minHeight: 9, maxHeight: 15)
                
                Text(tvShow.overview)
                    .frame(maxWidth: 240)
                    .lineLimit(4)
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        }
        .frame(maxWidth: .infinity)
        .background(Color("Secondary"))
    }
}

struct TVShowCellView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowCellView(tvShow: TVShow(id: 1, backgroundPath: "", voteAverage: 7.8, overview: "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.", name: "Pretty Little Liars", firstAirDate: "2010-06-08"))
    }
}
