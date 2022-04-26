//
//  UserModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/26.
//

import Foundation

struct UserModel: Codable {
    var name = "";
    var phoneNumber = 0;
    var picURL = "";
    
    enum UserKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case picURL = "pic_url"  //key不对应的解决办法
        case name = "name"
    }
    
    init(from decoder: Decoder) throws{
        let value = try? decoder.container(keyedBy: UserKeys.self);
        
        phoneNumber = (try? value?.decode(Int.self, forKey: .phoneNumber)) ?? 0;
        picURL = (try? value?.decode(String.self, forKey: .picURL)) ?? "";
        name = (try? value?.decode(String.self, forKey: .name)) ?? "";
        
    }
}
