//
//  LoginViewModelTest.swift
//  Coding-ChallengeTests
//
//  Created by Javier  on 27/12/22.
//

import XCTest
import Combine

@testable import Coding_Challenge

final class LoginViewModelTests: XCTestCase {
    
    private var viewModel: LoginViewModel<App>!
    private var loginStore: LoginStore!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        loginStore = APIManagerMock()
        viewModel = LoginViewModel<App>(loginStore: loginStore)
    }
    
    override func tearDownWithError() throws {
        loginStore = nil
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testLogin() throws {
        let loadLogin = XCTestExpectation(description: "Load Login")
        var loginFail = true
        
        viewModel.userName = "javier"
        viewModel.password = "123456"

        viewModel.$isLoginFail.sink { _ in

        } receiveValue: { login in
            loginFail = login
            loadLogin.fulfill()
        }.store(in: &cancellables)
        
        viewModel.requestToken()
        
        wait(for: [loadLogin], timeout: 1)
        XCTAssertFalse(loginFail)
    }
}
