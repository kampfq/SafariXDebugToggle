//
//  SafariExtensionHandler.swift
//  SafariXDebugToggleExtemsion
//
//  Created by Benjamin Issleib on 24.09.18.
//  Copyright © 2018 Benjamin Issleib. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    let xDebugState = XDebugState.instance
    let defaults = UserDefaults.init(suiteName: "group.com.converia.SafariXDebugToggle")

    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
            
            if(messageName == "updateToolbarIcon"){
                XDebugState.instance.xDebugIsActive[page] = userInfo?["debugOn"] as? Bool ?? false
                SFSafariApplication.setToolbarItemsNeedUpdate()
            }
        }

        
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
        getActivePage {
            let ideKey = self.defaults?.object(forKey:"IdeKey") as? String ?? "XDEBUG_ECLIPSE"
            guard let page = $0 else {return}
            page.dispatchMessageToScript(withName: "toggleXdebug", userInfo: [ "ideKey": ideKey ])
            let xdebugIsActiveOncurrentPage =  XDebugState.instance.xDebugIsActive[page] ?? false
            if(xdebugIsActiveOncurrentPage == true){
                XDebugState.instance.xDebugIsActive[page] = nil
            } else {
                XDebugState.instance.xDebugIsActive[page] = true
            }
            SFSafariApplication.setToolbarItemsNeedUpdate()

        
        }
        
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
       
        
        getActivePage {
            guard let page = $0 else {return}
            let xdebugIsActiveOncurrentPage =  XDebugState.instance.xDebugIsActive[page] ?? false
            if(xdebugIsActiveOncurrentPage == true){
                window.getToolbarItem { $0?.setBadgeText("1") }
            } else {
                window.getToolbarItem { $0?.setBadgeText(nil) }
            }
        }

        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }
    
    func getActivePage(completionHandler: @escaping (SFSafariPage?) -> Void) {
        SFSafariApplication.getActiveWindow {$0?.getActiveTab {$0?.getActivePage(completionHandler: completionHandler)}}
    }

}
