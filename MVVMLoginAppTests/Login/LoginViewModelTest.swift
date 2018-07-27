
//  Copyright © 2018 CCH. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxCocoa

@testable import CCHMobile

class LoginViewModelTest: XCTestCase {
    
    func testUsernameFieldNotEmpty() {
        let loginVM = LoginViewModel()
        loginVM.usernameText.accept("abc")
        loginVM.passwordText.accept("test")
        XCTAssertTrue(loginVM.validateFields())
    }
   
}
