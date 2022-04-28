//
//  JSONDecoderExtension.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/26.
//

import Foundation

extension JSONDecoder {
    class func jsonDecoder<T: Codable>(_ type: T.Type,from data: Data?) -> T? {
        guard let data = data else {
            return nil;
        }
        let json = JSONDecoder();
        var jsonItem: T? = nil;
        do {
            jsonItem = try json.decode(type, from: data)
        } catch {
            print("data convert json error: \(error)");
        }
        
        return jsonItem;
    }
    class func jsonDecoder<T: Codable>(_ type: T.Type,fromAny data: Any?) -> T? {
        if let data = data as? Data {
            return jsonDecoder(type, from: data);
        }
        guard let data = data else {
            return nil;
        }
        if let stringValue = data as? String {
            return jsonDecoder(type, from: stringValue.data(using: .utf8));
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted);
        return jsonDecoder(type, from: jsonData);
    }
}
