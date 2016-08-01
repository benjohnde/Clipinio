//
//  CMClip.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

class CMClip {
    private let CMPreviewLength = 36
    
    var content = String()
    var preview: String {
        get {
            if self.content.characters.count > CMPreviewLength {
                let index = self.content.index(self.content.startIndex, offsetBy: CMPreviewLength)
                return self.content.substring(to: index)
            }
            return self.content
        }
    }
    
    init(content: String) {
        self.content = content
    }
}
