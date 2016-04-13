//
//  CMPasteboard.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa
import Carbon

class CMPasteboard: NSObject, CMPasteboardObserverDelegate {
    private let CMPasteboardSize = 16
    private let pasteboard = NSPasteboard.generalPasteboard()
    private var observer: CMPasteboardObserver?
    var clips = [CMClip]()
    
    override init() {
        super.init()
        observer = CMPasteboardObserver(delegate: self)
    }
    
    private func top() -> CMClip? {
        if let string = pasteboard.stringForType(NSPasteboardTypeString) {
            return CMClip(content: string)
        }
        return nil
    }
    
    func clear() {
        while clips.count > 1 {
            clips.removeLast()
        }
    }
    
    private func addClip(clip: CMClip) -> Bool {
        if !clips.contains({ $0.content == clip.content }) {
            if clips.count + 1 > CMPasteboardSize {
                clips.removeLast()
            }
            clips.insert(clip, atIndex: 0)
            return true
        }
        moveToTop(clip)
        return false
    }
    
    private func moveToTop(clip: CMClip) {
        let index = clips.indexOf({$0.content == clip.content})
        guard (index != nil) else { return }
        clips.removeAtIndex(index!)
        clips.insert(clip, atIndex: 0)
    }
    
    func prepareClipForPaste(index: Int) {
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(clips[index].content, forType: NSPasteboardTypeString)
    }
    
    func invokePasteCommand() {
        let src = CGEventSourceCreate(CGEventSourceStateID.HIDSystemState)
        let location = CGEventTapLocation.CGHIDEventTap
        let events = [
            CGEventCreateKeyboardEvent(src, CGKeyCode(kVK_ANSI_V), true),
            CGEventCreateKeyboardEvent(src, CGKeyCode(kVK_ANSI_V), false)
        ]
        events.forEach({
            CGEventSetFlags($0, CGEventFlags.MaskCommand)
            CGEventPost(location, $0)
        })
    }
    
    // MARK: - CMPasteboardObserverDelegate
    
    func updatePasteboard() {
        if let top = top() {
            addClip(top)
        }
    }
}
