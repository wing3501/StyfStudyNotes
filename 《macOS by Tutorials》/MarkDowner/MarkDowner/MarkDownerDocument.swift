//
//  MarkDownerDocument.swift
//  MarkDowner
//
//  Created by styf on 2022/9/21.
//

import SwiftUI
import UniformTypeIdentifiers

// ✅文件统一标识符： https://developer.apple.com/documentation/uniformtypeidentifiers/system-declared_uniform_type_identifiers
// ✅ 对于Markdown文件，是 net.daringfireball.markdown 遵循 public.plain-text。文件扩展名为 .markdown .md

// 1. 在Targets——info——Document Types 中添加 新类型
// 2. 在imported Type Identifiers 中添加 新类型

import MarkdownKit

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
    
    static var exampleMarkdown: UTType {
        UTType(importedAs: "net.daringfireball.markdown")
    }
}

struct MarkDownerDocument: FileDocument {
    var text: String
    
    var html: String {
        let markdown = MarkdownParser.standard.parse(text)
        return HtmlGenerator.standard.generate(doc: markdown)
    }

    init(text: String = "Hello, world!") {// 文档默认内容
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.exampleText,.exampleMarkdown] }//✅ 规定了app能打开的文档类型

    // init和fileWrapper 处理了打开文档、保存文档的工作
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
