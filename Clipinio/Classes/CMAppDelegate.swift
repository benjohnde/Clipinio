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
    @IBOutlet weak var __statusMenu: NSMenu!
    @IBOutlet weak var __clipsMenu: NSMenu!
    @IBOutlet weak var __versionMenuItem: NSMenuItem!
    
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    private var hotkeyInterceptor: CMHotkeyInterceptor?
    
    let pasteboard = CMPasteboard()
    var clipsMenu: CMClipsMenu?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        setupStatusBarItemMenu()
        setupVersionItem()
        hotkeyInterceptor = CMHotkeyInterceptor(delegate: self)
        clipsMenu = CMClipsMenu(delegate: self)
    }
    
    // MARK: - NSMenu
    
    private func setupVersionItem() {
        let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        __versionMenuItem.title = "Version: \(version)"
    }
    
    // MARK: - CMStatusIcon
    
    private func setupStatusBarItemMenu() {
        let icon = NSImage(named: "statusIcon")!
        icon.template = true
        statusItem.image = icon
        statusItem.menu = __statusMenu
    }
    
    @IBAction func __resetEntries(sender: AnyObject) {
        pasteboard.clear()
    }
    
    // MARK: - NSMenuDelegate
    
    func menuWillOpen(menu: NSMenu) {
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
