//
//  CMAppDelegate.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

@NSApplicationMain
class CMAppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, CMHotkeyInterceptorDelegate, CMPopupMenuDelegate, CMClipsMenuDelegate {
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    private var hotkeyInterceptor: CMHotkeyInterceptor?
    let pasteboard = CMPasteboard()
    var clipsMenu: CMClipsMenu?
    
    @IBOutlet weak var __statusMenu: NSMenu!
    @IBOutlet weak var __clipsMenu: NSMenu!
    @IBOutlet weak var __versionMenuItem: NSMenuItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        initializeClipinio()
    }
    
    func initializeClipinio() {
        setupStatusBarItemMenu()
        hotkeyInterceptor = CMHotkeyInterceptor(delegate: self)
        clipsMenu = CMClipsMenu(delegate: self)
    }
    
    func setupStatusBarItemMenu() {
        let icon = NSImage(named: "statusIcon")!
        icon.template = true
        statusItem.image = icon
        statusItem.menu = __statusMenu
    }
    
    @IBAction func __resetEntries(sender: AnyObject) {
        pasteboard.clear()
    }
    
    private func setupVersionItem() {
        let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        __versionMenuItem.title = "Version: " + version
    }
    
    // MARK: - NSMenuDelegate
    
    func menuWillOpen(menu: NSMenu) {
        setupVersionItem()
        clipsMenu!.fill()
    }
    
    // MARK: - CMHotkeyInterceptorDelegate
    
    func showPasteMenu() {
        let menu = CMPopupMenu(delegate: self, clips: pasteboard.clips)
        menu.showPopupMenu()
    }
    
    // MARK: - CMPopupMenuDelegate
    
    func menuItemSelected(index: Int) {
        pasteboard.prepareClipForPaste(index)
        pasteboard.invokePasteCommand()
    }
}
