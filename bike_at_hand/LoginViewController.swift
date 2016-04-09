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
    
    @IBOutlet weak var checkingIfLoggedLabel: UILabel!
    @IBOutlet weak var loginPanelStackView: UIStackView!

    
    //MARK: UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAPI = APIFactory.getAPIWithMockedUserAPIAndPersistencyManager()
        
        initializeReactivness()
        checkUserAuthenticated()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setPreviousUsername()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userAuthenticatedSegue" {
            
            //Setting userAPI variable to the appropriate view controllers of TableBarNavigationController
            (((segue.destinationViewController as! UITabBarController).viewControllers![0] as! UINavigationController).topViewController as! StationListViewController).userAPI = userAPI
            (((segue.destinationViewController as! UITabBarController).viewControllers![1] as! UINavigationController).topViewController as! MapViewController).userAPI = userAPI
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
                
                self.userAPI.authenticate(
                    self.usernameTextField.text!,
                    password: self.passwordTextField.text!,
                    success: {
                            
                        self.callFunctionInMainThread {
                            self.networkIndicator.stopAnimating()
                            self.performSegueWithIdentifier("userAuthenticatedSegue", sender: nil)
                        }
                    },
                    error: { message in
                        self.callFunctionInMainThread {
                            self.showAlert(message, cancellationHandler: {action in
                                self.networkIndicator.stopAnimating()
                            })
                        }
                    }
                )
            })
    }
    
    //MARK: Private helpers
    
    
    
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
    
    private func checkUserAuthenticated() {
        loginPanelStackView.userInteractionEnabled = false
        networkIndicator.startAnimating()
        checkingIfLoggedLabel.hidden = false
        
        userAPI.checkIfLogged({
            self.callFunctionInMainThread {
                self.enableLoginForm()
                self.performSegueWithIdentifier("userAuthenticatedSegue", sender: nil)
            }
            },
            notLoggedCallback: {
                self.enableLoginForm()
            }
        )
    }
    
    private func enableLoginForm() {
        self.loginPanelStackView.userInteractionEnabled = true
        self.networkIndicator.stopAnimating()
        self.checkingIfLoggedLabel.hidden = true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
