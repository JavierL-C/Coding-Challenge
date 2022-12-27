//
//  TVShowLastSeasonView.swift
//  Coding-Challenge
//
//  Created by Javier  on 27/12/22.
//

import SwiftUI

struct TVShowLastSeasonView: View {
    
    var seasons: [Season]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Last Season")
                .frame(maxWidth: 320, alignment: .leading)
                .foregroundColor(Color("Primary"))
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.leading, 20)

            HStack(spacing: 10) {
                CustomAsyncImage(url: seasons.last?.posterURL, placeholder: {
                    Image("Primary Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200)
                })
                .frame(maxWidth: 180, maxHeight: 280)
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(seasons.last?.name ?? "Season 1")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Text(seasons.last?.airDate ?? "Nov 10, 19")
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                    
                    Button {
                        print("Show seasons next feature")
                    } label: {
                        Text("View All Seasons")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .light, design: .rounded))
                            .padding(9)
                    }
                    .background(Color("Primary"))
                    .cornerRadius(5)
                }
            }
            .padding(.leading, 20)
        }
        .frame(minWidth: 350, alignment: .leading)
        .background(Color("Secondary"))
    }
}

struct TVShowLastSeasonView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowLastSeasonView(seasons: [Season(id: 1, posterPath: "", seasonNumber: 1, overview: "", name: "", airDate: "Nov 10, 19")])
    }
}
