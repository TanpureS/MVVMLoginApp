
//  Copyright © 2018 CCH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AFNetworking

protocol ValidationProtocol {
    //TODO Validation updates
}

class LoginViewModel {
    
    var model: LoginModel?
    var usernameText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    var rememberMeState = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    func signIn(success:@escaping () -> (), failure:@escaping (Error) -> ()) {
        //TODO Move few operations. Create a NetworkManager
        self.model = LoginModel(username: usernameText.value, password: passwordText.value)
        let url = URL(string:EndPoints.baseUrl)
        let sessionManager = AFHTTPSessionManager(baseURL: url)
        let parameters = ["grant_type":"password",
                         "client_id":"mycliendid",
                         "client_secret" : "mycliensecret",
                         "username": model?.username,
                         "password" : model?.password]

        sessionManager.post(EndPoints.authUrl, parameters:parameters, progress: nil, success: { (dataTask, responseObject) in
            success()
        }) { (_, error) in
            failure(error)
        }
    }
    
    
    func validateFields() -> Bool {
        return validateUsernameField() && validatePasswordField()
    }
    
    private func validateUsernameField() -> Bool {
        return !usernameText.value.isEmpty
    }
    
    private func validatePasswordField() -> Bool {
        return !passwordText.value.isEmpty
    }
}

extension LoginViewModel: ValidationProtocol {
    //TODO Update these functions
    private func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    private func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}

