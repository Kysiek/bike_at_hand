//
//  LoginViewController.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 13/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LoginViewController: UIViewController {

    
    var userAPI: UserAPI!
    
    //MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var networkIndicator: UIActivityIndicatorView!
    
    //MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAPI = APIFactory.getAPIWithMockedUserAPIAndPersistencyManager()
        
        initializeReactivness()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setPreviousUsername()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userAuthenticatedSegue" {
            let stationListViewController =
                ((segue.destinationViewController as! UITabBarController).viewControllers![0] as! UINavigationController)
                .topViewController as! StationListViewController
            stationListViewController.userAPI = userAPI
        }
    }
    
    //MARK: Reactiveness
    private func initializeReactivness() {
        
        let validUsernameSignal = usernameTextField.rac_textSignal()
            .toSignalProducer()
            .map({ textObj -> Bool in
                return self.isUsernameValid(textObj as! String)
            })
        
        
        let validPasswordSignal = passwordTextField.rac_textSignal()
            .toSignalProducer()
            .map({ textObj -> Bool in
                return self.isPasswordValid(textObj as! String)
            })
        
        let signInButtonActive = combineLatest(validPasswordSignal,validUsernameSignal)
            .map({ (usernameValid, passwordValid) -> Bool in
                return usernameValid && passwordValid
            })
        
        validUsernameSignal.startWithNext({ isValid in
            self.usernameTextField.backgroundColor = self.getColorForTextField(isValid)
        })
        validPasswordSignal.startWithNext({ isValid in
            self.passwordTextField.backgroundColor = self.getColorForTextField(isValid)
        })
        signInButtonActive.startWithNext({ enableSignInButton in
            if enableSignInButton {
                self.loginButton.enabled = true
            }
        })
        
        
        loginButton.rac_signalForControlEvents(.TouchUpInside)
            .doNext({ _ in
                self.networkIndicator.startAnimating()
                self.loginButton.enabled = false
            })
        .toSignalProducer()
            .startWithNext({ _ in
                self.userAPI.authenticate(self.usernameTextField.text!,
                    password: self.passwordTextField.text!,
                    complete: { success in
                        if success {
                            self.networkIndicator.stopAnimating()
                            self.performSegueWithIdentifier("userAuthenticatedSegue", sender: nil)
                        } else {
                            self.showAlert("Authentication has failed")
                        }
                    })
            })
    }
    
    //MARK: Private helpers
    
    func showAlert(message: String) {
        let allertController = UIAlertController(title: Config.AlertMessages.ErrorTitle, message: message, preferredStyle: .Alert)
        allertController.addAction(UIAlertAction(title: Config.AlertMessages.DoneButtonTitle, style: .Cancel, handler: nil))
        self.presentViewController(allertController, animated: true, completion: nil)
    }
    
    private func setPreviousUsername() {
        if let previousUsername = userAPI.getPreviousUsername() {
            usernameTextField.text = previousUsername
        }
    }
    
    private func isUsernameValid(username: String) -> Bool {
        return username.characters.count > 3
    }
    
    private func isPasswordValid(password: String) -> Bool {
        return password.characters.count > 3
    }
    
    private func getColorForTextField(isValid: Bool) -> UIColor {
        return isValid ? UIColor.greenColor() : UIColor.yellowColor()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
