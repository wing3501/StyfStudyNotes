//
//  AbilityViewModel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation

struct AbilityViewModel: Identifiable {
    var id: String {
        name
    }
    let name: String = "能力名称"
    let descriptionText: String = "能力描述：将技能列表的文本完全左对齐，并占满可用空间。这是设计要求，我们可以在外层控制 padding 来调整具体的位置。"
}
