//
//  Storage.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 07/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

class JSONStore<T> where T : Codable {
    let storageType: StorageType
    let filename: String
    
    init(storageType: StorageType, filename: String) {
        self.storageType = storageType
        self.filename = filename
        ensureFolderExists()
    }
    
    func save(_ object: T) {
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: fileURL)
        } catch let e {
            print("JSON store saving ERROR: \(e)")
        }
    }
    
    var storedValue: T? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(T.self, from: data)
        } catch let e {
            print("JSON store loading: \(e)")
            return nil
        }
    }
    
    private var folder: URL {
        return storageType.folder
    }
    
    private var fileURL: URL {
        return folder.appendingPathComponent(filename)
    }
    
    private func ensureFolderExists() {
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: folder.path, isDirectory: &isDir) {
            if isDir.boolValue {
                return
            }
            try? FileManager.default.removeItem(at: folder)
        }
        try? fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
    }
}
