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
    private let CMTimeInterval = TimeInterval(0.65)
    private let delegate: CMPasteboardObserverDelegate
    
    init(delegate: CMPasteboardObserverDelegate) {
        self.delegate = delegate
        super.init()
        startObserving()
    }
    
    private func startObserving() {
        Timer.scheduledTimer(timeInterval: CMTimeInterval, target: self, selector: .updatePasteboard, userInfo: nil, repeats: true)
    }
    
    func updatePasteboard() {
        delegate.updatePasteboard()
    }
}
