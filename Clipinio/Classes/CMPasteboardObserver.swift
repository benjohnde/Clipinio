//
//  CMPasteboardObserver.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

protocol CMPasteboardObserverProtocol {
    func updatePasteboard()
}

class CMPasteboardObserver: NSObject {
    let CMTimeInterval = NSTimeInterval(0.75)
    let delegate: CMPasteboardObserverProtocol
    
    init(delegate: CMPasteboardObserverProtocol) {
        self.delegate = delegate
        super.init()
        startObserving()
    }
    
    func startObserving() {
        NSTimer.scheduledTimerWithTimeInterval(CMTimeInterval, target: self, selector: Selector("updatePasteboard"), userInfo: nil, repeats: true)
    }
    
    func updatePasteboard() {
        delegate.updatePasteboard()
    }
}
