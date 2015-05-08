//
//  CMClipsMenu.swift
//  Clipinio
//
//  Created by Ben John on 08/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

protocol CMClipsMenuDelegate {
    var clipsMenu: NSMenu! { get }
    var pasteboard: CMPasteboard { get }
}

class CMClipsMenu: NSObject {
    let delegate: CMClipsMenuDelegate
    
    init(delegate: CMClipsMenuDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func fill() {
        clear()
        for (index, clip) in enumerate(delegate.pasteboard.clips) {
            var title = String(index) + ". " + clip.preview
            delegate.clipsMenu!.insertItemWithTitle(title, action: nil, keyEquivalent: "", atIndex: index + 2)
        }
    }
    
    private func clear() {
        while delegate.clipsMenu!.itemArray.count > 2 {
            delegate.clipsMenu!.removeItemAtIndex(delegate.clipsMenu!.itemArray.count - 1)
        }
    }
}
