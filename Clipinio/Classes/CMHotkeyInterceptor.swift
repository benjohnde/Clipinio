//
//  CMHotkeyInterceptor.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

protocol CMHotkeyInterceptorProtocol {
    func showPasteMenu(event: NSEvent)
}

class CMHotkeyInterceptor: NSObject {
    let delegate: CMHotkeyInterceptorProtocol
    
    init(delegate: CMHotkeyInterceptorProtocol) {
        self.delegate = delegate
        super.init()
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: handlerEvent)
    }
    
    func handlerEvent(event: NSEvent!) {
        if (isPasteDetected(event)) {
            delegate.showPasteMenu(event)
        }
    }
    
    func isShiftDetected(event: NSEvent) -> Bool {
        return event.modifierFlags.rawValue & NSEventModifierFlags.ShiftKeyMask.rawValue != 0
    }
    
    func isCommandDetected(event: NSEvent) -> Bool {
        return event.modifierFlags.rawValue & NSEventModifierFlags.CommandKeyMask.rawValue != 0
    }
    
    func isPasteDetected(event: NSEvent) -> Bool {
        return isShiftDetected(event) && isCommandDetected(event) && event.characters?.lowercaseString == "v"
    }
}
