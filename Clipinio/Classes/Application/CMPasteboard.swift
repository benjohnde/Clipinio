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
    fileprivate let pasteboard = NSPasteboard.general
    fileprivate var observer: CMPasteboardObserver?
    var clips = [CMClip]()
    
    override init() {
        super.init()
        observer = CMPasteboardObserver(delegate: self)
    }
    
    fileprivate func top() -> CMClip? {
        if let string = pasteboard.string(forType: NSPasteboard.PasteboardType.string) {
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
        let index = clips.firstIndex(where: {$0.content == clip.content})
        guard (index != nil) else { return }
        clips.remove(at: index!)
        clips.insert(clip, at: 0)
    }
    
    func prepareClipForPaste(_ index: Int) {
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(clips[index].content, forType: NSPasteboard.PasteboardType.string)
    }
    
    var isAccessibilityEnabled: Bool {
        return AXIsProcessTrustedWithOptions(nil)
    }
    
    func showAccessibilityAuthenticationAlert() {
        let alert = NSAlert()
        alert.messageText = "Please allow Accessibility"
        alert.informativeText = "To do this action please allow Accessibility in Security Privacy preferences located in System Preferences"
        alert.addButton(withTitle: "Open System Preferences")
        NSApp.activate(ignoringOtherApps: true)

        if alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn {
            openAccessibilitySettingWindow()
        }
    }

    @discardableResult
    func openAccessibilitySettingWindow() -> Bool {
        guard let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") else { return false }
        return NSWorkspace.shared.open(url)
    }
    
    func invokePasteCommand() {
        guard isAccessibilityEnabled else {
            showAccessibilityAuthenticationAlert()
            return
        }
        let src = CGEventSource(stateID: .combinedSessionState)
        src?.setLocalEventsFilterDuringSuppressionState([
            .permitLocalMouseEvents,
            .permitSystemDefinedEvents,
        ], state: .eventSuppressionStateSuppressionInterval)
        let events = [
            CGEvent(keyboardEventSource: src, virtualKey: CGKeyCode(kVK_ANSI_V), keyDown: true),
            CGEvent(keyboardEventSource: src, virtualKey: CGKeyCode(kVK_ANSI_V), keyDown: false)
        ]
        events.forEach({
            $0?.flags = .maskCommand
            $0?.post(tap: .cgAnnotatedSessionEventTap)
        })
    }
    
    // MARK: - CMPasteboardObserverDelegate
    
    func updatePasteboard() {
        if let top = top() {
            addClip(top)
        }
    }
}
