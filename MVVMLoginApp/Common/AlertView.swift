//
//  Copyright © 2018 CCH. All rights reserved.
//

import Foundation
import UIKit

struct AlertView {
    
    static func showAlert(title: String?, message: String?, controller: UIViewController?) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        
        let vc = controller ?? AppDelegate.sharedInstance().window?.rootViewController
        vc?.present(alertView, animated: true, completion: nil)
    }
    
    static func showAlert(title: String?, message: String?, controller: UIViewController?, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
         let okButton = UIAlertAction(title: "Ok", style: .default) { (okSelected) -> Void in
            completion()
         }
         let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         alert.addAction(okButton)
         alert.addAction(cancelButton)
         let vc = controller ?? AppDelegate.sharedInstance().window?.rootViewController
         vc?.present(alert, animated: true, completion: nil)
    }
    
}

