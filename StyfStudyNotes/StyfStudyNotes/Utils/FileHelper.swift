//
//  FileHelper.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation


struct FileHelper {
    static let fm = FileManager()
    
    /// 从沙盒加载Json文件
    /// - Parameters:
    ///   - directory: 文件夹目录
    ///   - name: 文件名
    /// - Returns: Json数据
    static func loadJSON<T: Codable>(from directory: FileManager.SearchPathDirectory,fileName name: String) throws -> T? {
        if let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first {
            let filePath = dirPath + "/" + name
            if fm.fileExists(atPath: filePath) {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
                    return try? JSONDecoder().decode(T.self, from: data)
                }
            }
        }
        throw AppError.fileNotFind
    }
    
    /// 把Json数据写入沙盒文件
    /// - Parameters:
    ///   - value: 数据
    ///   - directory: 文件夹目录
    ///   - name: 文件名
    static func writeJSON<T: Codable>(_ value: T,to directory: FileManager.SearchPathDirectory,fileName name: String) throws {
        if let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first {
            let filePath = dirPath + "/" + name
            if fm.fileExists(atPath: filePath) {
                try delete(from: directory, fileName: name)
            }
            if let data = try? JSONEncoder().encode(value) {
                fm.createFile(atPath: filePath, contents: data)
            }
        }
        throw AppError.fileNotFind
    }
    
    /// 删除文件
    /// - Parameters:
    ///   - directory: 文件夹目录
    ///   - name: 文件名称
    static func delete(from directory: FileManager.SearchPathDirectory,fileName name: String) throws {
        if let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first {
            let filePath = dirPath + "/" + name
            if fm.fileExists(atPath: filePath) {
                try fm.removeItem(at: URL(fileURLWithPath: filePath))
            }
        }
    }
    
    /// 创建文件
    /// - Parameters:
    ///   - name: 文件名
    ///   - directory: 文件夹目录
    ///   - contents: 文件数据
    /// - Returns: 文件路径
    static func create(fileName name: String,to directory: FileManager.SearchPathDirectory,with contents: Data?) -> String? {
        guard let dirPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first else { return nil }
        let filePath = dirPath + "/" + name
        if fm.fileExists(atPath: filePath) {
           try? delete(from: directory, fileName: name)
        }
        fm.createFile(atPath: filePath, contents: contents)
        return filePath
    }
    
}
