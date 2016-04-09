//
//  ViewControllerExtension.swift
//  bike_at_hand
//
//  Created by Krzysztof Maciążek on 09/04/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    internal func callFunctionInMainThread(functionToCall: () -> ()) {
        dispatch_async(dispatch_get_main_queue(),{
            functionToCall()
        })
    }
    internal func showAlert(message: String, cancellationHandler: ((UIAlertAction) -> Void)?) {
        let allertController = UIAlertController(title: Config.AlertMessages.ErrorTitle, message: message, preferredStyle: .Alert)
        allertController.addAction(UIAlertAction(title: Config.AlertMessages.DoneButtonTitle, style: .Cancel, handler: cancellationHandler))
        self.presentViewController(allertController, animated: true, completion: nil)
    }
}