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
        try super.tearDownWithError()
        loginStore = nil
        viewModel = nil
    }
    
    func testLoginSuccessFull() throws {
        let loadLogin = XCTestExpectation(description: "Load Login")
        var loginSuccess = false
        
        viewModel.userName = "javier"
        viewModel.password = "123456"

        viewModel.$isLoginSuccess.sink { _ in

        } receiveValue: { login in
            loginSuccess = login
            loadLogin.fulfill()
        }.store(in: &cancellables)
        
        viewModel.requestToken()
        
        wait(for: [loadLogin], timeout: 1)
        XCTAssertTrue(loginSuccess)
    }
    
    func testLoginFail() throws {
        let loadLogin = XCTestExpectation(description: "Load Login")
        var loginFail = false
        
        viewModel.userName = ""
        viewModel.password = ""

        viewModel.$isLoginFail.sink { _ in

        } receiveValue: { login in
            loginFail = login
            loadLogin.fulfill()
        }.store(in: &cancellables)
        
        viewModel.requestToken()
        
        wait(for: [loadLogin], timeout: 1)
        XCTAssertTrue(loginFail)
    }
}
