//
//  CMClip.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Cocoa

class CMClip: NSObject {
    let CMPreviewLength = 30
    
    var content = String()
    var preview: String {
        get {
            if count(self.content) > CMPreviewLength {
                return NSString(string: self.content).substringToIndex(CMPreviewLength) as String
            } else {
                return self.content
            }
        }
    }
    
    init(content: String) {
        self.content = content
    }
}
