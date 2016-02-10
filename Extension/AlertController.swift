//
//  AlertController.swift
//  AlertController
//
//  Created by Yuliia Veresklia on 2/10/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit

typealias AlertActionHandler = (UIAlertAction) -> Void

typealias TextFieldConfiguration = (UITextField) -> Void

extension UIAlertAction {
    
    class func defaultAction() -> UIAlertAction {
        
        return UIAlertAction(title: "Ok", style: .Default, handler: nil)
    }
}

extension UIAlertController {
    
    class func simpleError(message: String?) -> UIAlertController {
        
        return UIAlertController.defaultAlertController(NSLocalizedString("Error", comment: ""), message: message)
    }
    
    class func alert(title: String?, message: String?, buttons:[String]?, handlers: [AlertActionHandler]?) -> UIAlertController {
        
        let alertController = UIAlertController.defaultAlertController(title, message: message)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Destructive, handler: nil))
        
        guard let unwrappedButtons = buttons as [String]?, let unwrappedHandlers = handlers as [AlertActionHandler]? else {
            return alertController
        }
        
        alertController.addButtons(unwrappedButtons, handlers: unwrappedHandlers)
        
        return alertController
    }
    
    class func inputAlert(title: String?, message: String?, buttons: [String], handlers: [AlertActionHandler], textFields: [TextFieldConfiguration]) -> UIAlertController {
        
        let alertController = UIAlertController.defaultAlertController(title, message: message)
        
        alertController.addButtons(buttons, handlers: handlers)
        alertController.addInput(textFields)
        
        return alertController
    }
    
    class func actionSheetAlert(title: String?, message: String?, buttons: [String], handlers: [AlertActionHandler]) -> UIAlertController {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        controller.addButtons(buttons, handlers: handlers)
        controller.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Destructive, handler: nil))
        
        return controller
    }
}

private extension UIAlertController {
    
    class func defaultAlertController(title: String?, message: String?) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction.defaultAction())
        
        return alertController
    }
    
    func addButtons(buttons: [String], handlers: [AlertActionHandler]) {
        
        if buttons.count != handlers.count {
            fatalError("Handler inconsistency")
        }
        
        for (index, handler) in handlers.enumerate() {
            
            let action = UIAlertAction(title: buttons[index], style: .Default, handler: handler)
            addAction(action)
        }
    }
    
    func addInput(textFields: [TextFieldConfiguration]) {
        
        for (_, configuration) in textFields.enumerate() {
            
            addTextFieldWithConfigurationHandler(configuration)
        }
    }
}