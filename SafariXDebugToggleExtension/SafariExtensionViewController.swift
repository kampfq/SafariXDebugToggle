//
//  SafariExtensionViewController.swift
//  SafariXDebugToggleExtemsion
//
//  Created by Benjamin Issleib on 24.09.18.
//  Copyright © 2018 Benjamin Issleib. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
