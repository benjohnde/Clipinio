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
        delegate.pasteboard.clips.enumerate().forEach {
            let title = String($0) + ". " + $1.preview
            delegate.__clipsMenu!.insertItemWithTitle(title, action: nil, keyEquivalent: "", atIndex: $0 + 2)
        }
    }
    
    private func clear() {
        while delegate.__clipsMenu!.itemArray.count > 2 {
            delegate.__clipsMenu!.removeItemAtIndex(delegate.__clipsMenu!.itemArray.count - 1)
        }
    }
}
