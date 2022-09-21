//
//  Color.swift
//  MarkdownKit
//
//  Created by Matthias Zenger on 18/08/2019.
//  Copyright © 2019-2021 Google LLC.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#if os(iOS) || os(watchOS) || os(tvOS)

  import UIKit

  extension UIColor {
    
    public var hexString: String {
      guard let components = self.cgColor.components, components.count >= 3 else {
        return "#FFFFFF"
      }
      let red   = Int(round(components[0] * 0xff))
      let green = Int(round(components[1] * 0xff))
      let blue  = Int(round(components[2] * 0xff))
      return String(format: "#%02X%02X%02X", red, green, blue)
    }
  }

  public let mdDefaultColor = UIColor.darkText.hexString
  public let mdDefaultBackgroundColor = UIColor.systemBackground.hexString

#elseif os(macOS)

  import Cocoa

  extension NSColor {

    public var hexString: String {
      guard let rgb = self.usingColorSpaceName(NSColorSpaceName.calibratedRGB) else {
        return "#FFFFFF"
      }
      let red   = Int(round(rgb.redComponent * 0xff))
      let green = Int(round(rgb.greenComponent * 0xff))
      let blue  = Int(round(rgb.blueComponent * 0xff))
      return String(format: "#%02X%02X%02X", red, green, blue)
    }
  }

  public let mdDefaultColor = NSColor.textColor.hexString
  public let mdDefaultBackgroundColor = NSColor.textBackgroundColor.hexString

#endif
