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
    fileprivate let CMPasteboardSize = 16
    fileprivate let pasteboard = NSPasteboard.general()
    fileprivate var observer: CMPasteboardObserver?
    var clips = [CMClip]()
    
    override init() {
        super.init()
        observer = CMPasteboardObserver(delegate: self)
    }
    
    fileprivate func top() -> CMClip? {
        if let string = pasteboard.string(forType: NSPasteboardTypeString) {
            return CMClip(content: string)
        }
        return nil
    }
    
    func clear() {
        while clips.count > 1 {
            clips.removeLast()
        }
    }
    
    fileprivate func addClip(_ clip: CMClip) {
        if !clips.contains(where: { $0.content == clip.content }) {
            if clips.count + 1 > CMPasteboardSize {
                clips.removeLast()
            }
            clips.insert(clip, at: 0)
        }
        moveToTop(clip)
    }
    
    fileprivate func moveToTop(_ clip: CMClip) {
        let index = clips.index(where: {$0.content == clip.content})
        guard (index != nil) else { return }
        clips.remove(at: index!)
        clips.insert(clip, at: 0)
    }
    
    func prepareClipForPaste(_ index: Int) {
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(clips[index].content, forType: NSPasteboardTypeString)
    }
    
    func invokePasteCommand() {
        let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
        let location = CGEventTapLocation.cghidEventTap
        let events = [
            CGEvent(keyboardEventSource: src, virtualKey: CGKeyCode(kVK_ANSI_V), keyDown: true),
            CGEvent(keyboardEventSource: src, virtualKey: CGKeyCode(kVK_ANSI_V), keyDown: false)
        ]
        events.forEach({
            $0?.flags = CGEventFlags.maskCommand
            $0?.post(tap: location)
        })
    }
    
    // MARK: - CMPasteboardObserverDelegate
    
    func updatePasteboard() {
        if let top = top() {
            addClip(top)
        }
    }
}
