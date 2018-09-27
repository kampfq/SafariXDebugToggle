//
//  XDebugState.swift
//  SafariXDebugToggleExtension
//
//  Created by Benjamin Issleib on 27.09.18.
//  Copyright © 2018 Benjamin Issleib. All rights reserved.
//

import SafariServices

class XDebugState {
    static let instance = XDebugState()
    private init() {}
    
    var xDebugIsActive: [SFSafariPage: Bool] = [:]
}
