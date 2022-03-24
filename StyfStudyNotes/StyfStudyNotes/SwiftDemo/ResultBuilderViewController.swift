//
//  ResultBuilderViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/3/17.
//  【WWDC21 10253】使用 Swift 特性 Result Builder 定制 DSL
//   https://xiaozhuanlan.com/topic/9042736581

import UIKit

struct Smoothie {
    var id: String
    var title: String
    var makeIngredients: [MeasuredIngredient]
}

extension Smoothie {
    init(id: String,
         @IngredientBuilder _ makeIngredients: ()->(String,[MeasuredIngredient])
    ) {
        let (title,ingredients) = makeIngredients()
        self.init(id: id, title: title, makeIngredients: ingredients)
    }
}

struct MeasuredIngredient {
    var color: UIColor
    var value: Double
}

@resultBuilder
enum IngredientBuilder {
//    @available(
//        *, unavailable,
//        message: "first statement of SmoothieBuilder must be its description String"
//    )
    static func buildBlock(_ title: String,_ ingredients:MeasuredIngredient...) -> (String,[MeasuredIngredient]) {
        return (title,ingredients)
    }
}

@resultBuilder
enum SmoothieArrayBuilder {
    static func buildBlock(_ components: [Smoothie]...) -> [Smoothie] {
//            return components
        return components.flatMap { $0 } //解决返回值不统一问题
    }
    //当我们需要在 DSL 中进行 if... 条件判断，此时可以使用 buildOptional 进行构造。buildOptional 支持部分结果是 nil 的情况。
    static func buildOptional(_ component: [Smoothie]?) -> [Smoothie] {
        return component ?? []
    }
    //解决类型不统一问题
    static func buildExpression(_ expression: Smoothie) -> [Smoothie] {
        return [expression]
    }
    // 解决if-else问题
    static func buildEither(first component: [Smoothie]) -> [Smoothie] {
        return component
    }

    static func buildEither(second component: [Smoothie]) -> [Smoothie] {
        return component
    }
    // 解决空语句问题
    static func buildExpression(_ expression: Void) -> [Smoothie] {
        return []
    }
}

class ResultBuilderViewController: UIViewController {
    
    @SmoothieArrayBuilder
    static func all(includingPaid: Bool = true) -> [Smoothie] {
//        Smoothie(id: "一号", title: "一号", makeIngredients: [MeasuredIngredient(color: .white, value: 1.5),
//                                                            MeasuredIngredient(color: .red, value: 1.5),
//                                                            MeasuredIngredient(color: .yellow, value: 1.5)])
        Smoothie(id: "一号") {
            "一号"
            MeasuredIngredient(color: .white, value: 1.5)
            MeasuredIngredient(color: .red, value: 1.5)
            MeasuredIngredient(color: .yellow, value: 1.5)
        }
        if includingPaid {
            Smoothie(id: "二号", title: "二号", makeIngredients: [MeasuredIngredient(color: .white, value: 1.5),
                                                                MeasuredIngredient(color: .red, value: 1.5),
                                                                MeasuredIngredient(color: .yellow, value: 1.5)])
            Smoothie(id: "三号", title: "三号", makeIngredients: [MeasuredIngredient(color: .white, value: 1.5),
                                                                MeasuredIngredient(color: .red, value: 1.5),
                                                                MeasuredIngredient(color: .yellow, value: 1.5)])
        }else {
            Smoothie(id: "四号", title: "四号", makeIngredients: [MeasuredIngredient(color: .white, value: 1.5),
                                                                MeasuredIngredient(color: .red, value: 1.5),
                                                                MeasuredIngredient(color: .yellow, value: 1.5)])
        }
//        }else {
//            print("没有了")
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }

}
