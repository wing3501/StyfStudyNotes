//
//  二进制.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/2/26.
//

import Foundation
//移除最后一个 1
//a=n & (n - 1)

//获取最后一个 1
//diff=(n & (n-1)) ^ n

//基本操作
//a=0^a=a^0
//0=a^a
//由上面两个推导出：a=a^b^b

//交换两个数
//a=a^b
//b=a^b
//a=a^b
