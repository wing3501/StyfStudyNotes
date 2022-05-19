//
//  ComposingViews.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/19.
//

import SwiftUI

struct ComposingViews: View {
    var body: some View {
        ScrollView {
            //文字中插入图片
            InsertImagesIntoText()
            //给桥接的UIView创建modifier
            ModifiersForUIView()
            //包装UIView
            WrapUIView()
            //创建自定义Modifier
            CustomModifiers()
            //把View作为属性使用
            ViewsAsProperties()
            //通过+的重载组合Text
            CombineTextViews()
        }
    }
}

//-----------------------------
struct InsertImagesIntoText : View {
    
    var body: some View {
        TestWrap("文字中插入图片") {
            VStack {
                Text("Hello ") + Text(Image(systemName: "star")) + Text(" World!")
                
                (Text("Hello ") + Text(Image(systemName: "star")) + Text(" World!"))
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                
                Text("Goodbye ") + Text(Image(systemName: "star")) + Text(" World!")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }
        }
    }
}
//-----------------------------
struct ModifiersForUIView : View {
    @State private var text = ""
    @State private var placeHolder = "Hello, world!"
    var body: some View {
        TestWrap("给桥接的UIView创建modifier") {
            VStack {
                SearchField(text: $text)
                    .placeholder(placeHolder)

                Button("Tap me") {
                    // randomize the placeholder every press, to
                    // prove this works
                    placeHolder = UUID().uuidString
                }
            }
        }
    }
}

struct SearchField: UIViewRepresentable {
    @Binding var text: String

    private var placeholder = ""

    init(text: Binding<String>) {
        _text = text
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = placeholder
        return searchBar
    }

    // Always copy the placeholder text across on update
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
    }
}
// Any modifiers to adjust your search field – copy self, adjust, then return.
extension SearchField {
    func placeholder(_ string: String) -> SearchField {
        var view = self //拷贝自己
        view.placeholder = string
        return view
    }
}
//-----------------------------
struct WrapUIView : View {
    @State var text = NSMutableAttributedString(string: "")
    var body: some View {
        
        TestWrap("包装UIView") {
            VStack {
                TextView(text: $text)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }
    }
}


struct TextView: UIViewRepresentable {
    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
}
//-----------------------------
struct CustomModifiers : View {
    var body: some View {
        TestWrap("创建自定义Modifier") {
            VStack {
                Text("Hello, SwiftUI")
                    .modifier(PrimaryLabel())
            }
        }
    }
}

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}
//-----------------------------
struct ViewsAsProperties : View {
    let title = Text("Paul Hudson")
                    .bold()
    let subtitle = Text("Author")
                    .foregroundColor(.secondary)
    var body: some View {
        TestWrap("把View作为属性使用") {
            VStack {
                title
                    .foregroundColor(.red)
                subtitle
            }
        }
    }
}
//-----------------------------
struct CombineTextViews : View {
    
    var body: some View {
        TestWrap("通过加号的重载组合Text") {
            VStack {
                Text("SwiftUI ")
                    .foregroundColor(.red)
                + Text("is ")
                    .foregroundColor(.orange)
                    .fontWeight(.black)
                + Text("awesome")
                    .foregroundColor(.blue)
            }
        }
    }
}
//-----------------------------
struct ComposingViews_Previews: PreviewProvider {
    static var previews: some View {
        ComposingViews()
    }
}
