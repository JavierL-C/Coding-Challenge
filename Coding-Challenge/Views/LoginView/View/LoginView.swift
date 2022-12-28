//
//  LoginView.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import SwiftUI
import Combine

struct LoginView<R: AppRouter>: View {
    
    @StateObject var viewModel = LoginViewModel<R>()
    @State private var subscription: AnyCancellable?
    private var router: R?
    
    init(router: R) {
        self.router = router
    }
    
    private let gradients = Gradient(stops: [
        .init(color: Color("Primary"), location: 0.1),
        .init(color: Color.black, location: 0.8)
    ])
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradients, startPoint: .top, endPoint: .center)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 25) {
                        
                        Image("Primary Image")
                        
                        Spacer()
                            .frame(height: 82)
                        
                        TextField("Username", text: $viewModel.userName)
                            .autocapitalization(.none)
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                            .frame(width: 300, height: 60)
                            .background(Color.white)
                            .cornerRadius(5)
                        
                        SecureField("Pasword", text: $viewModel.password)
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                            .frame(width: 300, height: 60)
                            .background(Color.white)
                            .cornerRadius(5)
                        
                        Button(action: {
                            viewModel.router = router
                            viewModel.requestToken()
                            subscription = viewModel.$isLoginSuccess.sink(receiveValue: { isloginSuccess in
                                if isloginSuccess {
                                    viewModel.showHomeView()
                                    subscription?.cancel()
                                }
                            })
                        }) {
                            Text("Log in")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 300, height: 60)
                        .background(Color("Primary"))
                        .cornerRadius(5)
                    }
                )
            
            if viewModel.isLoading { LoadingView(scale: 3) }
        }
        .alert(isPresented: $viewModel.isLoginFail) {
            Alert(
                title: Text("Error"),
                message: Text("User name or password are incorrect"),
                dismissButton: .default(Text("Ok")))
        }
    }
}

struct LoadingView: View {
    
    var scale: Double
    
    var body: some View {
        Color(.systemBackground)
            .ignoresSafeArea()
            .opacity(0.10)
        
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .green))
            .scaleEffect(scale)
    }
}
