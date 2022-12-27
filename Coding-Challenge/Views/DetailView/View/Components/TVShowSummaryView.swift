//
//  TVShowSummaryView.swift
//  Coding-Challenge
//
//  Created by Javier  on 27/12/22.
//

import SwiftUI

struct TVShowSummaryView: View {
    
    var title: String
    var summary: String
    var creators: [Creator]
    var voteAverage: Double
    
    private var creatorsNames: String {
        let names = creators.map { $0.name }
        return names.joined(separator: ", ")
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Text("Summary")
                    .frame(maxWidth: 320, alignment: .leading)
                    .foregroundColor(Color("Primary"))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.top, 20)
                
                HStack(spacing: 110) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    
            
                    Button {
                        print("I liked")
                    } label: {
                        Image(systemName: "heart")
                            .foregroundColor(Color("Primary"))
                            .frame(width: 30, height: 30)
                            .font(Font.system(size: 20, weight: .bold))
                    }
                }
                .frame(maxWidth: 320, alignment: .leading)
                
                Text(summary)
                    .foregroundColor(.white)
                    .frame(maxWidth: 320)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Text("Created by \(creatorsNames)")
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, alignment: .leading)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            .frame(minWidth: 350, alignment: .leading)
            .background(Color("Secondary"))
            
            VStack {
                Text(String(format: "%.1f", voteAverage))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(Color("Primary"))
                    .cornerRadius(20)
                Spacer()
            }.offset(y: -20)
        }
    }
}

struct TVShowSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowSummaryView(title: "Rick and Morty", summary: "Rick is a mentally-unbalanced but scientifically-gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.", creators: [Creator(id: 1, profilePath: "", name: "Dan Harmon")], voteAverage: 8.0)
    }
}
