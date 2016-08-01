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
    func menuItemSelected(_ index: Int)
}

class CMPopupMenu: NSObject {
    private let delegate: CMPopupMenuDelegate
    private let menu = NSMenu()
    
    init(delegate: CMPopupMenuDelegate, clips: [CMClip]) {
        self.delegate = delegate
        super.init()
        clips.enumerated().forEach { addItemToMenu($0, clip: $1) }
    }
    
    private func addItemToMenu(_ position: Int, clip: CMClip) {
        let title = String(position) + ". " + clip.preview
        let item = menu.insertItem(withTitle: title, action: .clickOnMenuItem, keyEquivalent: String(position), at: position)
        item.target = self
    }
    
    func showPopupMenu() {
        menu.popUp(positioning: nil, at: NSEvent.mouseLocation(), in: nil)
    }
    
    func clickOnMenuItem(_ item: NSMenuItem) {
        let pos = menu.index(of: item)
        delegate.menuItemSelected(pos)
    }
}
