//
//  SwiftUIByExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/6.
//

import SwiftUI

struct SwiftUIByExample: View {
    
    enum Route: String, Hashable,CaseIterable {
        case OrderFoodAPP
        case StaticText
        case ImageShapeMedia
        case ViewLayout
        case StacksGridsScrollviews
        case UserInterfaceControls
        case RespondingToEvents
        case TapsAndGestures
        case AdvancedState
        case Lists
        case Forms
        case Containers
        case AlertsAndMenus
        case Presenting
        case Transforming
        case Drawing
        case Animation
        case ComposingViews
        case Data
        case Tooling
    }
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(Route.allCases, id: \.self) { e in
                    NavigationLink(value: e) {
                        Text(e.rawValue)
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .OrderFoodAPP:
                    OrderFoodAPP()
                case .StaticText:
                    StaticTextApp()
                case .ImageShapeMedia:
                    ImageShapeMedia()
                case .ViewLayout:
                    ViewLayoutDemo()
                case .StacksGridsScrollviews:
                    StacksGridsScrollviews()
                case .UserInterfaceControls:
                    UserInterfaceControls()
                case .RespondingToEvents:
                    RespondingToEvents()
                case .TapsAndGestures:
                    TapsAndGestures()
                case .AdvancedState:
                    AdvancedState()
                case .Lists:
                    ListsDemo()
                case .Forms:
                    FormsDemo()
                case .Containers:
                    ContainersDemo()
                case .AlertsAndMenus:
                    AlertsAndMenus()
                case .Presenting:
                    PresentingViewsDemo()
                case .Transforming:
                    TransformingViewsDemo()
                case .Drawing:
                    DrawingDemo()
                case .Animation:
                    AnimationDemo1()
                case .ComposingViews:
                    ComposingViews()
                case .Data:
                    HandleData()
                case .Tooling:
                    ToolingDemo()
                }
            }
        }
    }
}

struct SwiftUIByExample_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIByExample()
            .previewDevice("iPhone 13")
    }
}
