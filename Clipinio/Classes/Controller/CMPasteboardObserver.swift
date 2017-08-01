//
//  CMPasteboardObserver.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

private extension Selector {
    static let updatePasteboard = #selector(CMPasteboardObserver.updatePasteboard)
}

protocol CMPasteboardObserverDelegate {
    func updatePasteboard()
}

class CMPasteboardObserver: NSObject {
    fileprivate let CMTimeInterval = TimeInterval(0.65)
    fileprivate let delegate: CMPasteboardObserverDelegate
    
    init(delegate: CMPasteboardObserverDelegate) {
        self.delegate = delegate
        super.init()
        startObserving()
    }
    
    fileprivate func startObserving() {
        Timer.scheduledTimer(timeInterval: CMTimeInterval, target: self, selector: .updatePasteboard, userInfo: nil, repeats: true)
    }
    
    @objc func updatePasteboard() {
        delegate.updatePasteboard()
    }
}
