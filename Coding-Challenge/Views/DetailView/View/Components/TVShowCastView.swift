//
//  TVShowCastView.swift
//  Coding-Challenge
//
//  Created by Javier  on 27/12/22.
//

import SwiftUI

struct TVShowCastView: View {
    
    var cast: [Actor]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Cast")
                .frame(maxWidth: 320, alignment: .leading)
                .foregroundColor(Color("Primary"))
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(cast, id: \.self) { actorShow in
                        LazyVStack(spacing: 10) {
                            
                            CustomAsyncImage(url: actorShow.profileURL, placeholder: {
                                Image("Primary Image")
                                    .frame(width: 100, height: 100)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            })
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            
                            Text(actorShow.name)
                                .frame(width: 100, alignment: .center)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .padding(9)
                        }
                        
                    }
                }
            }
            .frame(maxWidth: 355, alignment: .leading)
        }
        .background(Color("Secondary"))

    }
}

struct TVShowCastView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowCastView(cast: [
            Actor(id: 1, profilePath: "", name: "Actor 1", order: 1),
            Actor(id: 2, profilePath: "", name: "Actor 2", order: 1)])
    }
}
