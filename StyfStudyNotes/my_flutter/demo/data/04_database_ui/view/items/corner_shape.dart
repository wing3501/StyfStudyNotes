import 'package:flutter/material.dart';

enum CornerType {
  TopLeftArrow,
  TopRightTag,
  TopRightTran
}

class CornerShape extends StatelessWidget {
  CornerShape(
      {Key key,
      this.text = "未开始",
      this.height = 20,
        this.type=CornerType.TopLeftArrow,
        this.color=Colors.red,
      this.width = 50})
      : super(key: key);
  final String text;
  final double height;
  final double width;
  final CornerType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var headIcon = Container(
      color: color,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 3),
      width: width,
      height: height,
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: Colors.white),
      ),
    );

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      child: headIcon,
      shape: TerShape(width, height, type),
      clipBehavior: Clip.antiAlias,
    );
  }
}

class TerShape extends ShapeBorder {
  final double width;
  final double height;
  final CornerType type;

  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    var path = Path();

    return buildShapeByType(path,type);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }

  TerShape(this.width, this.height, this.type);

  Path buildShapeByType(Path path, CornerType type) {
    switch (type){
      case CornerType.TopLeftArrow:
        path.moveTo(0, 0);
        path.lineTo(
          0,
          height,
        );
        path.lineTo(
          width*0.8,
          height,
        );
        path.lineTo(width, height/2);
        path.lineTo(width*0.8, 0);
        path.close();
        return path;
      case CornerType.TopRightTran:
        path.moveTo(width, 0);
        path.relativeLineTo(
          0,
          height,
        );
        path.lineTo(
          0,
          0,
        );
        path.close();
        return path;
      case CornerType.TopRightTag:
        // TODO: Handle this case.
        break;
    }

  }
}
