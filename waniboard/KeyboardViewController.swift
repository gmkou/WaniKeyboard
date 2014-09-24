//
//  KeyboardViewController.swift
//  waniboard
//
//  Created by Kosuke Nagano on 2014/09/24.
//  Copyright (c) 2014年 Kousuke Nagano. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var mainView: UIView!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xibView = NSBundle.mainBundle().loadNibNamed("CustomKeyboard", owner: self, options: nil)
        self.mainView = xibView[0] as UIView
        
        self.view.addSubview(mainView)
        
        for v in self.mainView.subviews as [UIButton]
        {
                v.addTarget(self, action: "btnPressed:", forControlEvents: .TouchUpInside)
        }

        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    
    func btnPressed(sender: AnyObject) {
        var btn = sender as UIButton
        var stringToInsert = ""
        let proxy = self.textDocumentProxy as UIKeyInput
        switch (btn.tag)
        {
        case 5:
                stringToInsert = "🐱"
        case 10:
                stringToInsert = "🐶"
        case 15:
                stringToInsert = "Wani"
        case 20:
                stringToInsert = "（・(ｪ)・）"
        default:
                stringToInsert = ""
        }
        proxy.insertText(stringToInsert)
    }

}
