//
//  CMHotkeyInterceptor.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa
import Carbon

protocol CMHotkeyInterceptorDelegate {
    func showPasteMenu()
}

class CMHotkeyInterceptor: NSObject {
    private let delegate: CMHotkeyInterceptorDelegate
    private var hotKey: HotKey
    
    init(delegate: CMHotkeyInterceptorDelegate) {
        self.delegate = delegate
        self.hotKey = HotKey(keyCode: kVK_ANSI_V, modifiers: cmdKey | shiftKey, block: {
            delegate.showPasteMenu()
        })
    }
}
