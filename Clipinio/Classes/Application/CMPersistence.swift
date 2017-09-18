//
//  CMPersistence.swift
//  Clipinio
//
//  Created by Ben John on 18.09.17.
//  Copyright © 2017 Ben John. All rights reserved.
//

import Foundation

fileprivate let CMLocalStorageFilename = "storage.json"

class CMPersistence {
    var appDirectory: URL {
        let possibleUrls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        guard let appSupportDir = possibleUrls.first else {
            fatalError()
        }
        guard let appBundleID = Bundle.main.bundleIdentifier else {
            fatalError()
        }
        return appSupportDir.appendingPathComponent(appBundleID)
    }
    
    var localStorageUrl: URL {
        return appDirectory.appendingPathComponent(CMLocalStorageFilename)
    }
    
    var localStorage: String? {
        set {
            try? newValue?.write(to: localStorageUrl, atomically: true, encoding: .utf8)
        }
        get {
            return try? String(contentsOf: localStorageUrl, encoding: .utf8)
        }
    }
    
    var clips: [CMClip] {
        set {
            guard let result = try? JSONEncoder().encode(newValue) else {
                return
            }
            guard let data = String(data: result, encoding: .utf8) else {
                return
            }
            self.localStorage = data
        }
        get {
            guard let localStorage = self.localStorage else {
                return [CMClip]()
            }
            guard let localData = localStorage.data(using: .utf8) else {
                return [CMClip]()
            }
            guard let clips = try? JSONDecoder().decode([CMClip].self, from: localData) else {
                return [CMClip]()
            }
            return clips
        }
    }
    
    init() {
        ensureAppDirectoryExists()
    }
    
    func ensureAppDirectoryExists() {
        try? FileManager.default.createDirectory(at: appDirectory, withIntermediateDirectories: false)
    }
}
