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
        VStack {
            VStack {
                CustomAsyncImage(url: tvShow.backgroundURL, placeholder: {
                    Image("Primary Image")
                        .padding(5)
                })
                
                Spacer()
                    .frame(minHeight: 10, maxHeight: 15)
                
                Text(tvShow.name)
                    .padding(5)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Primary"))
                
                Spacer()
                    .frame(minHeight: 11, maxHeight: 15)
                
                HStack(spacing: 35) {
                    Text(tvShow.firstAirDate)
                        .font(.system(size: 15, weight: .light, design: .rounded))
                        .foregroundColor(Color("Primary"))
                    
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("Primary"))
                            .frame(maxWidth: 14, maxHeight: 14)
                        Text(String(format: "%.2f", tvShow.voteAverage))
                            .font(.system(size: 15, weight: .light, design: .rounded))
                            .foregroundColor(Color("Primary"))
                    }
                }
                
                Spacer()
                    .frame(minHeight: 9, maxHeight: 15)
                
                Text(tvShow.description)
                    .frame(maxWidth: 175)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    .font(.system(size: 16, weight: .light, design: .rounded))
                    .lineLimit(4)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 185, maxHeight: 340)
            .background(Color("Secondary"))
            .cornerRadius(20)
    
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Almost Black"))
        
    }
}

struct TVShowCellView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowCellView(tvShow: TVShow(id: 1, backgroundPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg", voteAverage: 7.8, overview: "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.", name: "Pretty Little Liars", firstAirDate: "2010-06-08"))
    }
}
