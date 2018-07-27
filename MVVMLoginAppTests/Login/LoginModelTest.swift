
//  Copyright © 2018 CCH. All rights reserved.
//

import Foundation
import XCTest
@testable import CCHMobile

class LoginModelTest: XCTestCase {
    
    func testIsUsernameNotNil() {
        let loginModel = LoginModel(username: "mbnm", password: "test")
        XCTAssertFalse(loginModel.isUsernameEmpty())
    }
    
    func testIsPasswordNotNil() {
        let loginModel = LoginModel(username: "abc", password: "test")
        XCTAssertFalse(loginModel.isPasswordEmpty())
    }

}
