//
//  ReactiveForm.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/15.
//

import SwiftUI

struct ReactiveForm: View {
    // 数据模型使用 @ObservedObject 暴露给 SwiftUI
    @ObservedObject var model: ReactiveFormModel
    // $model is a ObservedObject<ExampleModel>.Wrapper
    // and $model.objectWillChange is a Binding<ObservableObjectPublisher>
    @State private var buttonIsDisabled = true
    // $buttonIsDisabled is a Binding<Bool>

    var body: some View {
        VStack {
            Text("Reactive Form")
                .font(.headline)

            Form {
//                用户更改值时，Binding 将触发引用模型上的更新，并让 SwiftUI 的组件知道，如果暴露的模型正在被更改，则组件的更改也即将发生。
                TextField("first entry", text: $model.firstEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .padding()

                TextField("second entry", text: $model.secondEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .padding()

                VStack {
                    ForEach(model.validationMessages, id: \.self) { msg in
                        Text(msg)
                            .foregroundColor(.red)
                            .font(.callout)
                    }
                }
            }

            Button(action: {}) {
                Text("Submit")
            }.disabled(buttonIsDisabled)
                .onReceive(model.submitAllowed) { submitAllowed in
                    self.buttonIsDisabled = !submitAllowed
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 1)
            )

            Spacer()
        }
    }
}

struct ReactiveForm_Previews: PreviewProvider {
    static var previews: some View {
        ReactiveForm(model: ReactiveFormModel())
    }
}
