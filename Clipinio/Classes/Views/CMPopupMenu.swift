//
//  CMPopupMenu.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

private extension Selector {
    static let clickOnMenuItem = #selector(CMPopupMenu.clickOnMenuItem(_:))
}

protocol CMPopupMenuDelegate {
    func menuItemSelected(index: Int)
}

class CMPopupMenu: NSObject {
    private let delegate: CMPopupMenuDelegate
    private let menu = NSMenu()
    
    init(delegate: CMPopupMenuDelegate, clips: [CMClip]) {
        self.delegate = delegate
        super.init()
        clips.enumerate().forEach { addItemToMenu($0, clip: $1) }
    }
    
    private func addItemToMenu(position: Int, clip: CMClip) {
        let title = String(position) + ". " + clip.preview
        let item = menu.insertItemWithTitle(title, action: .clickOnMenuItem, keyEquivalent: String(position), atIndex: position)
        item?.target = self
    }
    
    func showPopupMenu() {
        menu.popUpMenuPositioningItem(nil, atLocation: NSEvent.mouseLocation(), inView: nil)
    }
    
    func clickOnMenuItem(item: NSMenuItem) {
        let pos = menu.indexOfItem(item)
        delegate.menuItemSelected(pos)
    }
}
