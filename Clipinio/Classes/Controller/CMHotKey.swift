//
//  CMHotKey.swift
//  Clipinio
//
//  Created by Ben John on 10/12/15.
//  Copyright © 2015 Ben John. All rights reserved.
//

import Cocoa
import Carbon

class HotKey {
    private var hotKey: EventHotKeyRef? = nil
    private var eventHandler: EventHandlerRef? = nil

    init(keyCode: Int, modifiers: Int, block: () -> ()) {
        let hotKeyID = EventHotKeyID(signature: 1, id: 1)
        var eventType = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed))

        let ptr = UnsafeMutablePointer<() -> ()>(allocatingCapacity: 1)
        ptr.initialize(with: block)

        let eventHandlerUPP: EventHandlerUPP = {(_: OpaquePointer?, _: OpaquePointer?, ptr: UnsafeMutablePointer<()>?) -> OSStatus in
            guard let pointer = ptr else { fatalError() }
            UnsafeMutablePointer<() -> ()>(pointer).pointee()
            return noErr
        }

        InstallEventHandler(GetApplicationEventTarget(), eventHandlerUPP, 1, &eventType, ptr, &eventHandler)
        RegisterEventHotKey(UInt32(keyCode), UInt32(modifiers), hotKeyID, GetApplicationEventTarget(), OptionBits(0), &hotKey)
    }

    deinit {
        UnregisterEventHotKey(hotKey)
        RemoveEventHandler(eventHandler)
    }
}
