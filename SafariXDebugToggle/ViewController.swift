//
//  ViewController.swift
//  SafariXDebugToggle
//
//  Created by Benjamin Issleib on 24.09.18.
//  Copyright © 2018 Benjamin Issleib. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let defaults = UserDefaults.init(suiteName: "group.com.converia.SafariXDebugToggle")
    @IBOutlet weak var IdeKeyInputField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let ideKey = self.defaults?.object(forKey:"IdeKey") as? String ?? "XDEBUG_ECLIPSE"
        IdeKeyInputField.stringValue = ideKey
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func saveIdeKey(_ sender: NSButton) {
        let ideKey = IdeKeyInputField.stringValue
        
        self.defaults?.set(ideKey,forKey: "IdeKey")
        
    }
    
}

