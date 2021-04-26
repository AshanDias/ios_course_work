//
//  LoginFlowUITest.swift
//  Ashan_Dias_cobsccomp192p_028UITests
//
//  Created by Ashan Dias on 2021-04-26.
//

import XCTest

class LoginFlowUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
       
       
    }
    
    func testLogin(){
        let app = XCUIApplication()
        app.launch()

        let emailField = app.textFields["emailtext"]
        let pwdField = app.secureTextFields["pwdtext"]
        let btn = app.buttons["loginbtn"]
        let logout = app.buttons["logoutbtn"]
      
        emailField.tap()
        emailField.typeText("ashan@gmail.com")
        
        
        pwdField.tap()
        pwdField.typeText("Ashan@123")
        
        btn.tap()
        
       
        logout.tap()
        
        app.tap()
      
        
    }
    
    
    func testInvalidLogin(){
        let app = XCUIApplication()
        app.launch()

        let emailField = app.textFields["emailtext"]
        let pwdField = app.secureTextFields["pwdtext"]
        let btn = app.buttons["loginbtn"]
        let logout = app.buttons["logoutbtn"]
      
        emailField.tap()
        emailField.typeText("ashangmail.com")
        
        
        pwdField.tap()
        pwdField.typeText("ashan123")
        
        btn.tap()
        
       
        
        
        app.tap()
      
        
    }
    
    
    
    func testForgotPwd(){
        let app = XCUIApplication()
        app.launch()
        
        let lbl = app.buttons["forgotpwd"]
        lbl.tap()
        
        let emailField = app.textFields["emailtxt"]
      
        emailField.tap()
        emailField.doubleTap()
        emailField.typeText("ashandias.info@gmail.com")
        
        let btn = app.buttons["btnprocess"]
        btn.tap()
        
           
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: btn, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        
    }

   
}

