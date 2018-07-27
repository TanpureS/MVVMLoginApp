//
//  Copyright © 2018 CCH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var isRememberMeSelected: UISwitch!
    
    var loginViewModel = LoginViewModel()//TODO
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerObservers()
    }
    
    private func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func configureBinding() {
        _ = usernameTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.usernameText)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.passwordText)
        _ = isRememberMeSelected.rx.isOn.bind(to: loginViewModel.rememberMeState)
        
        //Binding from VM to View
        loginViewModel.rememberMeState.asObservable()
            .do(onNext: { [weak self] val in
                self?.isRememberMeSelected.isOn = val
            })
            .subscribe { _ in
            }.disposed(by: disposeBag)

    
        loginButton.rx.tap
            .`do`(onNext:  { [weak self] in
                self?.usernameTextField.resignFirstResponder()
                self?.passwordTextField.resignFirstResponder()
            }).subscribe(onNext: { [weak self] in
                guard self?.loginViewModel.validateFields() ?? false else {
                    AlertView.showAlert(title: "Alert", message: "Please enter the username and password.", controller: self)
                    return
                }
                //TODO Network Reachability
                self?.activityIndicator.startAnimating()
                self?.authenticate()
            }).disposed(by: disposeBag)
    }
    
    private func authenticate() {
        //TODO
        loginViewModel.signIn(success: { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.performSegue(withIdentifier: "SegueHome", sender: nil)
        }) { [weak self] (error) in
            self?.activityIndicator.stopAnimating()
            let message = error.localizedDescription // "Problem in signing in. Kindly check your credentials"
            AlertView.showAlert(title: "Error", message: message, controller: self)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Keyboard Notification handler
    @objc func keyboardWillShow(notification: NSNotification) {        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= 150
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += 150
        }
    }
}
    


