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
    
    fileprivate let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    fileprivate var hotkeyInterceptor: CMHotkeyInterceptor?
    
    let persistence = CMPersistence()
    let pasteboard = CMPasteboard()
    var clipsMenu: CMClipsMenu?
    
    // MARK: - Application lifecycle
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusBarItemMenu()
        setupVersionItem()
        pasteboard.clips = persistence.clips
        hotkeyInterceptor = CMHotkeyInterceptor(delegate: self)
        clipsMenu = CMClipsMenu(delegate: self)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        persistence.clips = pasteboard.clips
    }
    
    // MARK: - NSMenu
    fileprivate func setupVersionItem() {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        __versionMenuItem.title = "Version: \(version)"
    }
    
    // MARK: - CMStatusIcon
    fileprivate func setupStatusBarItemMenu() {
        let icon = NSImage(named: "statusIcon")!
        icon.isTemplate = true
        statusItem.image = icon
        statusItem.menu = __statusMenu
    }
    
    @IBAction func __resetEntries(_ sender: AnyObject) {
        pasteboard.clear()
    }
    
    // MARK: - NSMenuDelegate
    func menuWillOpen(_ menu: NSMenu) {
        clipsMenu!.fill()
    }
    
    // MARK: - CMHotkeyInterceptorDelegate
    func showPasteMenu() {
        let menu = CMPopupMenu(delegate: self, clips: pasteboard.clips)
        menu.showPopupMenu()
    }
    
    // MARK: - CMPopupMenuDelegate
    func menuItemSelected(_ index: Int) {
        pasteboard.prepareClipForPaste(index)
        pasteboard.invokePasteCommand()
    }
}
