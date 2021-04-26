//
//  RegisterFlow.swift
//  Ashan_Dias_cobsccomp192p_028UITests
//
//  Created by Ashan Dias on 2021-04-26.
//

import XCTest

class RegisterFlow: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }
    
    func register(){
        let app = XCUIApplication()
        app.launch()
        
        let btn = app.buttons["register"]
        btn.tap()
        
        let email = app.textFields["email"]
        let pwd = app.secureTextFields["pwd"]
        let cpwd = app.secureTextFields["cpwd"]
        let tel = app.textFields["tel"]
        
        email.tap()
        email.typeText("ashandias.info+12@gmail.com")
        
        pwd.tap()
        pwd.typeText("Ashan@123")
        
        cpwd.tap()
        cpwd.typeText("Ashan@123")
        
        tel.tap()
        tel.typeText("1234567890")
        
        btn.tap()
        
        
    }
    
    func invalidRegister(){
        let app = XCUIApplication()
        app.launch()
        
        let btn = app.buttons["register"]
        btn.tap()
        
        let email = app.textFields["email"]
        let pwd = app.secureTextFields["pwd"]
        let cpwd = app.secureTextFields["cpwd"]
        let tel = app.textFields["tel"]
        
        email.tap()
        email.typeText("ashandias.info+12gmail.com")
        
        pwd.tap()
        pwd.typeText("ashan123")
        
        cpwd.tap()
        cpwd.typeText("Ashan@123")
        
        tel.tap()
        tel.typeText("1234567890")
        
        btn.tap()
    }


}
