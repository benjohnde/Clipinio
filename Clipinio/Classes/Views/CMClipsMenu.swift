//
//  CMClipsMenu.swift
//  Clipinio
//
//  Created by Ben John on 08/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

protocol CMClipsMenuDelegate {
    var pasteboard: CMPasteboard { get }
    var __clipsMenu: NSMenu! { get }
}

class CMClipsMenu: NSObject {
    private let delegate: CMClipsMenuDelegate
    
    init(delegate: CMClipsMenuDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func fill() {
        clear()
        for (index, clip) in delegate.pasteboard.clips.enumerate() {
            let title = String(index) + ". " + clip.preview
            delegate.__clipsMenu!.insertItemWithTitle(title, action: nil, keyEquivalent: "", atIndex: index + 2)
        }
    }
    
    private func clear() {
        while delegate.__clipsMenu!.itemArray.count > 2 {
            delegate.__clipsMenu!.removeItemAtIndex(delegate.__clipsMenu!.itemArray.count - 1)
        }
    }
}
