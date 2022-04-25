//
//  FileHelper.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation


struct FileHelper {
    static func loadJSON<T: Codable>(from directory: FileManager.SearchPathDirectory,fileName name: String) throws -> T? {
        if let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first {
            let filePath = dirPath + "/" + name
            let fm = FileManager()
            if fm.fileExists(atPath: filePath) {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
                    return try? JSONDecoder().decode(T.self, from: data)
                }
            }
        }
        throw AppError.fileNotFind
    }
    static func writeJSON<T: Codable>(_ value: T,to directory:FileManager.SearchPathDirectory,fileName name: String) throws {
        if let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first {
            let filePath = dirPath + "/" + name
            let fm = FileManager()
            if fm.fileExists(atPath: filePath) {
                try delete(from: directory, fileName: name)
            }
            if let data = try? JSONEncoder().encode(value) {
                fm.createFile(atPath: filePath, contents: data)
            }
        }
        throw AppError.fileNotFind
    }
    static func delete(from directory: FileManager.SearchPathDirectory,fileName name: String) throws {
        if let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first {
            let filePath = dirPath + "/" + name
            let fm = FileManager()
            if fm.fileExists(atPath: filePath) {
                try fm.removeItem(at: URL(fileURLWithPath: filePath))
            }
        }
    }
}
