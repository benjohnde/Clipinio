//
//  CMAppDelegate.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

@NSApplicationMain
class CMAppDelegate: NSObject, NSApplicationDelegate, CMHotkeyInterceptorProtocol, CMPopupMenuProtocol {
    let pasteboard = CMPasteboard()
    
    // MARK: - NSApplicationDelegate
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        acquirePrivileges()
        initializeClipinio()
    }
    
    // MARK: - CMHotkeyInterceptorProtocol
    func showPasteMenu(event: NSEvent) {
        var menu = CMPopupMenu(delegate: self, clips: pasteboard.clips)
        menu.showPopupMenu(event)
    }
    
    // MARK: - CMPopupMenuProtocol
    func selectedMenuItem(index: Int) {
        pasteboard.prepareClipForPaste(index)
        pasteboard.invokePasteCommand()
    }
    
    // MARK: - Application Initialization
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    func initializeClipinio() {
        initializeStatusBar()
        CMHotkeyInterceptor(delegate: self)
    }
    
    func initializeStatusBar() {
        let icon = NSImage(named: "statusIcon")!
        icon.setTemplate(true)
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
    
    func acquirePrivileges() {
        let flag = kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString
        let options: CFDictionary = [flag: true]
        if (AXIsProcessTrustedWithOptions(options) == 0) {
            NSApplication.sharedApplication().terminate(nil)
        }
    }
}
