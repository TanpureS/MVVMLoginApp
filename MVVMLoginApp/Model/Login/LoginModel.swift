
//  Copyright © 2018 CCH. All rights reserved.
//

import Foundation

class LoginModel {
    var username: String = ""
    var password: String = ""
    var isRememberMe: Bool = false
    
    convenience init(username: String, password: String) {
        self.init()
        self.username = username
        self.password = password
    }
    
    
    func isUsernameEmpty () -> Bool {
        return self.username.isEmpty
    }
    
    func isPasswordEmpty () -> Bool {
        return self.password.isEmpty
    }
}
