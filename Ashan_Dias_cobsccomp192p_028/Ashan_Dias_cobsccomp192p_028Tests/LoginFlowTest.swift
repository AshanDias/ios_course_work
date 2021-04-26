//
//  LoginFlowTest.swift
//  Ashan_Dias_cobsccomp192p_028Tests
//
//  Created by Ashan Dias on 2021-04-26.
//

import XCTest
@testable import Ashan_Dias_cobsccomp192p_028


class LoginFlowTest: XCTestCase {

    let authService = AuthService()
    func testValidEmail(){
        let result = authService.validateEmail(email: "ashandias.info@gmail.com")
        XCTAssertEqual(result, true)
    }
    
    func testInvalidEmailAddress(){
        let result = authService.validateEmail(email: "ashandias.infogmail.com")
        XCTAssertEqual(result, false)
    }
    
    func testValidPassword(){
        let result = authService.isValidPassword(pwd: "Test@123")
        XCTAssertEqual(result, true)
    }
    
    func testInvalidPassword(){
        let result = authService.isValidPassword(pwd: "test123")
        XCTAssertEqual(result, false)
    }
}
