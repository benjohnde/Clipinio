//
//  CMPasteboard.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

class CMPasteboard: NSObject, CMPasteboardObserverDelegate {
    private let CMPasteboardSize = 10
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
        if !clips.contains({$0.content == clip.content}) {
            if clips.count + 1 > CMPasteboardSize {
                clips.removeLast()
            }
            clips.insert(clip, atIndex: 0)
            return true
        }
        moveToTop(clip)
        return false
    }
    
    private func indexOf(clip: CMClip) -> Int? {
        for (index, c) in clips.enumerate() {
            if c.content == clip.content {
                return index
            }
        }
        return nil
    }
    
    private func moveToTop(clip: CMClip) {
        let index = indexOf(clip)!
        clips.removeAtIndex(index)
        clips.insert(clip, atIndex: 0)
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
        if let top = top() {
            addClip(top)
        }
    }
}
