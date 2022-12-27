//
//  TVShowDetailView.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import SwiftUI

struct TVShowDetailView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Image("Primary Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.top)
                
                Spacer()
                    .frame(maxWidth: .infinity)
                    .background(Color("Almost Black"))
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            VStack {
                VStack(spacing: 15) {
                    
                    Text("Summary")
                        .frame(maxWidth: 320, alignment: .leading)
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding(.top, 20)
                    
                    HStack(spacing: 110) {
                        Text("Rick and Morty")
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
                    
                    
                    Text("Rick is a mentally-unbalanced but scientifically-gifted old man who has recently reconnected with his family. He spends most of his time involving his young grandson Morty in dangerous, outlandish adventures throughout space and alternate universes. Compounded with Morty's already unstable family life, these events cause Morty much distress at home and school.")
                        .foregroundColor(.white)
                        .frame(maxWidth: 320)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Text("Created by Dan Harmon, Justin Roiland")
                        .foregroundColor(.white)
                        .frame(maxWidth: 320, alignment: .leading)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                    
                    Spacer().frame(maxHeight: 20)
                    
                    Text("Last Season")
                        .frame(maxWidth: 320, alignment: .leading)
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
        
                    HStack(spacing: 10) {
                        Image("Primary Image")
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Seson 4")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                            Text("Nov 10, 19")
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
                    
                    Spacer().frame(maxHeight: 20)
                    
                    Text("Cast")
                        .frame(maxWidth: 320, alignment: .leading)
                        .foregroundColor(Color("Primary"))
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0...10, id: \.self) { index in
                                VStack(spacing: 10) {
                                    Image("Primary Image")
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                    
                                    Text("Cast")
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
                .frame(minWidth: 350, minHeight: 733, alignment: .leading)
                .background(Color("Secondary"))
                .overlay(
                    Text("8.0")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40, alignment: .center)
                        .background(Color("Primary"))
                        .cornerRadius(20), alignment: .topTrailing
                )
                .cornerRadius(20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
        }
        .frame(alignment: .bottom)
    }
}

struct TVShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowDetailView()
    }
}
