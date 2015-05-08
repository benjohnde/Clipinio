//
//  CMPasteboard.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

class CMPasteboard: NSObject, CMPasteboardObserverDelegate {
    let CMPasteboardSize = 10
    let pasteboard = NSPasteboard.generalPasteboard()
    var clips = [CMClip]()
    
    override init() {
        super.init()
        CMPasteboardObserver(delegate: self)
    }
    
    func top() -> CMClip? {
        let string = pasteboard.stringForType(NSPasteboardTypeString)
        if (string != nil) {
            return CMClip(content: string!)
        }
        return nil
    }
    
    func clear() {
        while clips.count > 1 {
            clips.removeLast()
        }
    }
    
    func addClip(clip: CMClip) -> Bool {
        if !contains(clip) {
            if clips.count + 1 > CMPasteboardSize {
                clips.removeLast()
            }
            clips.insert(clip, atIndex: 0)
            return true
        }
        moveToTop(clip)
        return false
    }
    
    func indexOf(clip: CMClip) -> Int? {
        for (index, c) in enumerate(clips) {
            if c.content == clip.content {
                return index
            }
        }
        return nil
    }
    
    func moveToTop(clip: CMClip) {
        var index = indexOf(clip)!
        clips.removeAtIndex(index)
        clips.insert(clip, atIndex: 0)
    }
    
    func contains(clip: CMClip) -> Bool {
        for c in clips {
            if c.content == clip.content {
                return true
            }
        }
        return false
    }
    
    func prepareClipForPaste(index: Int) {
        pasteboard.declareTypes([NSPasteboardTypeString], owner: nil)
        pasteboard.setString(clips[index].content, forType: NSPasteboardTypeString)
    }
    
    func invokePasteCommand() {
        let key = NSAppleScript(source: "tell application \"System Events\" to keystroke \"v\" using {command down}")
        key?.executeAndReturnError(nil)
    }
    
    // MARK: - CMPasteboardObserverDelegate
    func updatePasteboard() {
        var topClip = top()
        if topClip != nil {
            addClip(topClip!)
        }
    }
}
