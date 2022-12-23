//
//  LoginView.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var userName = ""
    @State private var password = ""
    
    var viewModel: LoginViewModelRepresentable?
    
    init(viewModel: LoginViewModelRepresentable) {
        self.viewModel = viewModel
    }
    
    init() {
        // init just for preview
    }
    
    private let gradients = Gradient(stops: [
        .init(color: Color("Primary"), location: 0.1),
        .init(color: Color.black, location: 0.8)
    ])
    
    var body: some View {
        LinearGradient(gradient: gradients, startPoint: .top, endPoint: .center)
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack(spacing: 25) {
                    Image("Primary Image")
                    
                    Spacer()
                        .frame(height: 82)
                    
                    TextField("Username", text: $userName)
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                        .frame(width: 300, height: 60)
                        .background(Color.white)
                        .cornerRadius(5)
                    
                    SecureField("Pasword", text: $password)
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                        .frame(width: 300, height: 60)
                        .background(Color.white)
                        .cornerRadius(5)
                    
                    Button(action: {
                        viewModel?.login(userName: userName, password: password)
                    }) {
                        Text("Log in")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            
                    }
                    .frame(width: 300, height: 60)
                    .background(Color("Primary"))
                    .cornerRadius(5)
                }
            )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
