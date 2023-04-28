/// Copyright (c) 2023 Kodeco Inc.
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// https://www.kodeco.com/38422105-swiftlint-in-depth

// 报告错误的脚本  0以外都是错误
// echo "${PROJECT_DIR}/MarvelProductions/DataProvider/ProductionsDataProvider.swift:39:7: error: I don't like the name of this class!"
// exit 1

// 推荐脚本
//
// export PATH="$PATH:/opt/homebrew/bin"
// if which swiftlint > /dev/null; then
//   swiftlint
// else
//   echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
// fi

// 官方文档
// https://realm.github.io/SwiftLint/orphaned_doc_comment.html
// https://realm.github.io/SwiftLint/rule-directory.html

// 工程目录下创建.swiftlint.yml
// touch .swiftlint.yml

// 排除文件夹
//excluded:
//  - DerivedData

// 排除注释上的错误规则
//disabled_rules:
//  - orphaned_doc_comment

//force_cast: warning # 1 强制转换配置为警告
//
//identifier_name: # 2 变量排除一些常用的
//  excluded:
//    - i
//    - id
//    - x
//    - y
//    - z

// 还有另一种方法可以禁用规则。您可以通过在产生冲突的代码块之前添加注释来忽略规则。例如：
// // swiftlint:disable [rule_name], [another_rule_name], ....
// 这将完全禁用指定的规则。从该注释开始，直到文件结束或再次启用它们：
// // swiftlint:enable [rule_name], [another_rule_name], ....
// 还有一个选项可以禁用下一行和仅下一行中出现的规则：
// // swiftlint:disable:next [rule_name], [another_rule_name], ....
//但如果下一行没有触发该规则，SwiftLint将警告说，此禁用毫无意义。这很方便，所以您不必担心再次启用该规则。


// 允许一些正常的长行情况
// 这将忽略URL、函数声明和注释的行长度规则。
//line_length:
//  ignores_urls: true
//  ignores_function_declarations: true
//  ignores_comments: true

// 函数体最长70行
//function_body_length:
//    warning: 70

//opt_in_rules:
//  - indentation_width
//  - force_unwrapping
//  - redundant_type_annotation
//  - force_try
//  - operator_usage_whitespace
//
//indentation_width:
//  indentation_width: 2  #2个空格缩进


// 定制自己的规则
//// Not OK
//var array = [Int]()
//var dict = [String: Int]()
//
//// OK
//var array: [Int] = []
//var dict: [String: Int] = [:]

//custom_rules:
//  array_constructor: # 1 您首先要为新规则创建一个标识符，并在下面包含它的所有属性。
//    name: "Array/Dictionary initializer" # 2 此规则的名称。
//    regex: '[let,var] .+ = (\[.+\]\(\))' # 3 您可以为要搜索的冲突定义正则表达式。
//    capture_group: 1 # 4 如果正则表达式匹配的一部分是冲突所在的位置，并且您正在使用捕获组来关注它，那么您可以在此处指定捕获组的编号。如果您没有使用捕获组，则不需要包含此属性。
//    message: "Use explicit type annotation when initializing empty arrays and dictionaries" # 5 您要显示的用于描述该问题的消息。
//    severity: warning # 6 设置为error或warning。

// 使用远程规则
//swiftlint --config [yml file path or url]

//export PATH="$PATH:/opt/homebrew/bin"
//if which swiftlint > /dev/null; then
//  swiftlint --config ~/swiftlintrules.yml
//else
//  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
//fi

// 修改
//excluded:
//  - ${PWD}/DerivedData



import SwiftUI

@main
struct AppMain: App {
  var body: some Scene {
    WindowGroup {
      ProductionsListView(productionsList: ProductionsDataProvider().loadData())
    }
  }
}
