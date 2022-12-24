//
//  LoginView.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @State private var userName = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var cancellables = Set<AnyCancellable>()
    
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
        ZStack {
            LinearGradient(gradient: gradients, startPoint: .top, endPoint: .center)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack(spacing: 25) {
                        
                        Image("Primary Image")
                        
                        Spacer()
                            .frame(height: 82)
                        
                        TextField("Username", text: $userName)
                            .autocapitalization(.none)
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
                            didTapButtonLogin()
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
            
            if isLoading { LoadingView() }
        }
    }
    
    private func didTapButtonLogin() {
        isLoading = true
        viewModel?.requestToken()

        viewModel?.requestTokenSubject.sink { completion in
            switch completion {
                case .finished:
                    print("Log in success", completion)
                case .failure(_):
                    break
            }
        } receiveValue: { requestToken in
            viewModel?.login(userName: userName, password: password, requestToken: requestToken)
        }.store(in: &cancellables)
        
        viewModel?.loadSubject.sink(receiveCompletion: { _ in }, receiveValue: { isLoading in
            self.isLoading = isLoading
            DispatchQueue.main.async {
                viewModel?.showHomeView()
            }
        }).store(in: &cancellables)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoadingView: View {
    var body: some View {
        Color(.systemBackground)
            .ignoresSafeArea()
            .opacity(0.10)
        
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .green))
            .scaleEffect(3)
    }
}
