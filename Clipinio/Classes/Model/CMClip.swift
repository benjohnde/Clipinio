//
//  CMClip.swift
//  Clipinio
//
//  Created by Ben John on 07/05/15.
//  Copyright (c) 2015 Ben John. All rights reserved.
//

import Foundation

fileprivate let CMPreviewLength = 36

struct CMClip: Decodable, Encodable {
    let content: String
}

extension CMClip {
    var preview: String {
        return String(self.content.prefix(CMPreviewLength))
    }
}
