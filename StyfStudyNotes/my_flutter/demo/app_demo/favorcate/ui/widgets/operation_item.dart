import 'package:flutter/material.dart';
import 'package:favorcate/core/extension/int_extension.dart';

class YFOperationItem extends StatelessWidget {
  final Widget _icon;
  final String _title;
  YFOperationItem(this._icon, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon,
          SizedBox(
            width: 3.px,
          ),
          Text(_title)
        ],
      ),
    );
  }
}
