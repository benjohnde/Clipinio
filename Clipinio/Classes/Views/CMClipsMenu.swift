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
    fileprivate let delegate: CMClipsMenuDelegate
    
    init(delegate: CMClipsMenuDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func fill() {
        clear()
        delegate.pasteboard.clips.enumerated().forEach {
            let title = String($0.0) + ". " + $0.1.preview
            delegate.__clipsMenu!.insertItem(withTitle: title, action: nil, keyEquivalent: "", at: $0.0 + 2)
        }
    }
    
    fileprivate func clear() {
        while delegate.__clipsMenu!.items.count > 2 {
            delegate.__clipsMenu!.removeItem(at: delegate.__clipsMenu!.items.count - 1)
        }
    }
}
