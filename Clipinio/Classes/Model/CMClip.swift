//
//  CMClip.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

class CMClip {
    fileprivate let CMPreviewLength = 36
    
    var content = String()
    var preview: String {
        return String(self.content.prefix(CMPreviewLength))
    }
    
    init(content: String) {
        self.content = content
    }
}
