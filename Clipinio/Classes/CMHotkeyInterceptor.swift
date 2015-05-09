//
//  CMHotkeyInterceptor.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

protocol CMHotkeyInterceptorDelegate {
    func showPasteMenu(event: NSEvent)
}

class CMHotkeyInterceptor: NSObject {
    private let delegate: CMHotkeyInterceptorDelegate
    
    init(delegate: CMHotkeyInterceptorDelegate) {
        self.delegate = delegate
        super.init()
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: handlerEvent)
    }
    
    private func handlerEvent(event: NSEvent!) {
        if (isPasteDetected(event)) {
            delegate.showPasteMenu(event)
        }
    }
    
    private func isShiftDetected(event: NSEvent) -> Bool {
        return event.modifierFlags.rawValue & NSEventModifierFlags.ShiftKeyMask.rawValue != 0
    }
    
    private func isCommandDetected(event: NSEvent) -> Bool {
        return event.modifierFlags.rawValue & NSEventModifierFlags.CommandKeyMask.rawValue != 0
    }
    
    private func isPasteDetected(event: NSEvent) -> Bool {
        return isShiftDetected(event) && isCommandDetected(event) && event.characters?.lowercaseString == "v"
    }
}
