//
//  DrawingDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/19.
//

import SwiftUI

struct DrawingDemo: View {
    var body: some View {
        ScrollView {
            //使用UIBezierPath和CGPath
            UseUIBezierPathAndCGPath()
            //绘制棋盘
            DrawCheckerboard()
            //绘制多边形
            DrawPolygons()
            //绘制自定义路径
            CustomPath()
            //5种内置形状
            FiveShapes()
        }
    }
}

//-----------------------------
struct ConvertViewToImage : View {
    var textView: some View {
            Text("Hello, SwiftUI")
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
    }
    var body: some View {
        TestWrap("视图转图像、截屏") {
            VStack {
                textView

                Button("Save to image") {
                    let image = textView.snapshot()

//                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

//-----------------------------
struct UseUIBezierPathAndCGPath : View {
    var body: some View {
        TestWrap("使用UIBezierPath和CGPath") {
            VStack {
                ScaledBezier(bezierPath: .logo)
                    .stroke(lineWidth: 2)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

struct ScaledBezier: Shape {
    let bezierPath: UIBezierPath

    func path(in rect: CGRect) -> Path {
        
        //如果使用的是CGPath
        //则 let path = Path(yourCGPath)
        
        let path = Path(bezierPath.cgPath)

        // Figure out how much bigger we need to make our path in order for it to fill the available space without clipping.
        let multiplier = min(rect.width, rect.height)

        // Create an affine transform that uses the multiplier for both dimensions equally.
        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)

        // Apply that scale and send back the result.
        return path.applying(transform)
    }
}

extension UIBezierPath {
    /// The Unwrap logo as a Bezier path.
    static var logo: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.534, y: 0.5816))
        path.addCurve(to: CGPoint(x: 0.1877, y: 0.088), controlPoint1: CGPoint(x: 0.534, y: 0.5816), controlPoint2: CGPoint(x: 0.2529, y: 0.4205))
        path.addCurve(to: CGPoint(x: 0.9728, y: 0.8259), controlPoint1: CGPoint(x: 0.4922, y: 0.4949), controlPoint2: CGPoint(x: 1.0968, y: 0.4148))
        path.addCurve(to: CGPoint(x: 0.0397, y: 0.5431), controlPoint1: CGPoint(x: 0.7118, y: 0.5248), controlPoint2: CGPoint(x: 0.3329, y: 0.7442))
        path.addCurve(to: CGPoint(x: 0.6211, y: 0.0279), controlPoint1: CGPoint(x: 0.508, y: 1.1956), controlPoint2: CGPoint(x: 1.3042, y: 0.5345))
        path.addCurve(to: CGPoint(x: 0.6904, y: 0.3615), controlPoint1: CGPoint(x: 0.7282, y: 0.2481), controlPoint2: CGPoint(x: 0.6904, y: 0.3615))
        return path
    }
}

//-----------------------------
struct DrawCheckerboard : View {
    var body: some View {
        TestWrap("绘制棋盘") {
            VStack {
                Checkerboard(rows: 16, columns: 16)
                    .fill(.red)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

struct Checkerboard: Shape {
    let rows: Int
    let columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}
//-----------------------------
struct DrawPolygons : View {
    var body: some View {
        TestWrap("绘制多边形") {
            VStack {
                Star(corners: 5, smoothness: 0.45)
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .background(.green)
            }
        }
    }
}
struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: Double

    func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return Path() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / Double(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        var path = Path()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: Double = 0

        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}

//-----------------------------
struct CustomPath : View {
    var body: some View {
        TestWrap("绘制自定义路径") {
            VStack {
                ShrinkingSquares()
                    .stroke()
                    .frame(width: 200, height: 200)
            }
        }
    }
}
//首先我们需要遵守Shape协议
struct ShrinkingSquares: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        for i in stride(from: 1, through: 100, by: 5.0) {
            let rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            let insetRect = rect.insetBy(dx: i, dy: i)
            path.addRect(insetRect)
        }

        return path
    }
}
//-----------------------------
struct FiveShapes : View {
    var body: some View {
        TestWrap("5种内置形状") {
            ZStack {
                Rectangle()
                    .fill(.gray)
                    .frame(width: 200, height: 200)

                RoundedRectangle(cornerRadius: 25, style: .continuous)//style决定您是想要经典圆角（圆形）还是Apple的稍微平滑的替代品（连续）。
                    .fill(.red)
                    .frame(width: 200, height: 200)

                Capsule()
                    .fill(.green)
                    .frame(width: 100, height: 50)

                Ellipse()//椭圆
                    .fill(.blue)
                    .frame(width: 100, height: 50)

                Circle()
                    .fill(.white)
                    .frame(width: 100, height: 50)
            }
        }
    }
}

//-----------------------------
struct DrawingDemo_Previews: PreviewProvider {
    static var previews: some View {
        DrawingDemo()
    }
}
