//
//  CMPopupMenu.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

protocol CMPopupMenuDelegate {
    func menuItemSelected(index: Int)
}

class CMPopupMenu: NSObject {
    private let delegate: CMPopupMenuDelegate
    private let menu = NSMenu()
    
    init(delegate: CMPopupMenuDelegate, clips: [CMClip]) {
        self.delegate = delegate
        super.init()
        for (index, clip) in clips.enumerate() {
            addItemToMenu(index, clip: clip)
        }
    }
    
    private func addItemToMenu(position: Int, clip: CMClip) {
        let title = String(position) + ". " + clip.preview
        let item = menu.insertItemWithTitle(title, action: Selector("clickOnMenuItem:"), keyEquivalent: String(position), atIndex: position)
        item?.target = self
    }
    
    func showPopupMenu(event: NSEvent) {
        menu.popUpMenuPositioningItem(nil, atLocation: event.locationInWindow, inView: nil)
    }
    
    func clickOnMenuItem(item: NSMenuItem) {
        let pos = menu.indexOfItem(item)
        delegate.menuItemSelected(pos)
    }
}
