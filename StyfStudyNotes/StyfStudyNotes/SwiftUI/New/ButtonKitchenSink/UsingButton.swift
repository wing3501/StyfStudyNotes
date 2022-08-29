//
//  UsingButton.swift
//  
//
//  Created by styf on 2022/8/26.
//  SwiftUI Button Tutorial: Customization : https://www.raywenderlich.com/34851726-swiftui-button-tutorial-customization

import SwiftUI

struct UsingButton: View {
    var body: some View {
        KitchenSinkView()
    }
}

struct KitchenSinkView: View {
  @State private var isDisabled = false
  @State private var applyTint = false
  @State private var actionTaken = ""
  @State private var menuSelection: String?
  private let menuOptions = ["English", "Spanish", "French", "German"]

  var body: some View {
    List {
      borderedButtonView
      customButtonsView
      buttonRolesView
      buttonShapesView
      buttonSizesView
      menuButtonsView
    }
    .navigationTitle("Button Kitchen Sink")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var borderedButtonView: some View {
    Section {
      Button {
      } label: {
        Text("Bordered Prominent")
      }
      .buttonStyle(.borderedProminent)

      Button {
      } label: {
        Text("Bordered")
      }
      .buttonStyle(.bordered)
        
      Button {
      } label: {
        Text("Borderless")
      }
      .buttonStyle(.borderless)
        
    } header: {
      Text("Bordered Buttons")
    } footer: {
      Toggle(isOn: $applyTint) {
        Label("Apply Tint", systemImage: "paintbrush")
      }
    }
    .tint(applyTint ? .mint : .primary)//应用色调，会根据样式改变文字或者背景色
  }

  private var customButtonsView: some View {
    Section {
      Button {
      } label: {
          Text("Gradient Button")
      }
      .buttonStyle(.gradient)
      .disabled(isDisabled)

      Button {
      } label: {
        Text("Custom Gradient Button")
      }
      .buttonStyle(GradientStyle(colors: [.red, .yellow, .green]))
      .disabled(isDisabled)
        
    } header: {
      Text("Custom Buttons")
    } footer: {
      Toggle(isOn: $isDisabled) {
        Label("Disable Buttons", systemImage: "checkmark.circle.fill")
      }
    }
  }
    //按钮角色和按钮样式类似，会根据运行环境，自动应用对应的外观
  private var buttonRolesView: some View {
    Section {
      Button(role: .destructive) {
      } label: {
        Text("Destructive")
      }
      .swipeActions {// 当按钮在List中时，角色会影响侧滑样式
          // 2
          Button(role: .destructive) {
            actionTaken = "Remove"
          } label: {
            Label("Remove", systemImage: "trash")
          }
          // 3
          Button(role: .cancel) {
            actionTaken = "Add"
          } label: {
            Label("Add", systemImage: "plus")
          }
          // 4
          Button {
            actionTaken = "Share"
          } label: {
            Label("Share", systemImage: "square.and.arrow.up")
          }
          .tint(.mint)
      }

      Button(role: .cancel) {
      } label: {
        Text("Cancel")
      }
    } header: {
      Text("Button Roles")
    } footer: {
      Text("Action Taken: \(actionTaken)")
    }
  }
    //设置按钮的形状和尺寸
  private var buttonShapesView: some View {
    Section {
      HStack {
        Button {
        } label: {
          Text("Rounded")
        }
        .buttonBorderShape(.roundedRectangle)
          
        Button {
        } label: {
          Text("Custom Radius")
        }
        .buttonBorderShape(.roundedRectangle(radius: 12))
          
        Button {
        } label: {
          Text("Capsule")
        }
        .buttonBorderShape(.capsule)
          
      }
    } header: {
      Text("Button Shapes")
    }
    .buttonStyle(.bordered)
  }
    // 设置按钮尺寸
  private var buttonSizesView: some View {
    Section {
      HStack {
        Button {
        } label: {
          Text("Mini")
        }
        .controlSize(.mini)
          
        Button {
        } label: {
          Text("Small")
        }
        .controlSize(.small)
          
        Button {
        } label: {
          Text("Regular")
        }
        .controlSize(.regular)

        Button {
        } label: {
          Text("Large")
        }
        .controlSize(.large)
      }
    } header: {
      Text("Button Sizes")
    }
    .buttonStyle(.bordered)
  }

  private var menuButtonsView: some View {
    Section {
      HStack {
        Menu(menuSelection ?? "Select Language") {
          ForEach(menuOptions, id: \.self) { menuOption in
            Button {
              menuSelection = menuOption
            } label: {
              Text(menuOption)
            }
          }
        }
        .menuStyle(.customMenu)
      }
    } header: {
      Text("Menu")
    }
  }
}

struct UsingButton_Previews: PreviewProvider {
    static var previews: some View {
        UsingButton()
    }
}
