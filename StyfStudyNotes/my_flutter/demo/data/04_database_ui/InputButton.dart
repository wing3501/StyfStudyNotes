import 'package:flutter/material.dart';

typedef SubmitCallback = void Function(String str);

class InputButtonConfig {
  final double height;//高度
  final IconData iconData;//图标
  final String hint;//提示文字
  final double fontSize;//文字大小
  final Widget front;//前面图标
  final bool submitClear;//是否提交清空

  const InputButtonConfig(
      {this.height = 36,
      this.iconData = Icons.add,
      this.fontSize = 14,
      this.submitClear = true,
      this.front,
      this.hint = "I want to say..."});
}

class InputButton extends StatefulWidget {
  final SubmitCallback onSubmit;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;
  final InputButtonConfig config;

  InputButton({Key key, this.onSubmit,
      this.onChanged,
    this.onTap,
      this.config = const InputButtonConfig()})
      : super(key: key);

  @override
  _InputButtonState createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
  var _text = "";
  var _height;
  var _fontSize;
  var _radius;

  @override
  void initState() {
    _height = widget.config.height;
    _fontSize = widget.config.fontSize;
    _radius = Radius.circular(_height / 3.6);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      controller: TextEditingController(text: _text),
      maxLines: 1,
      style: TextStyle(
          fontSize: _fontSize,
          color: Colors.lightBlue,
          backgroundColor: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.config.hint,
          hintStyle: TextStyle(color: Colors.black26, fontSize: _fontSize),
          contentPadding: EdgeInsets.only(left: 14.0,
              bottom: _height / 2 - _fontSize*0.8, top: _height / 2 - _fontSize / 2),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.only(topLeft: _radius, bottomLeft: _radius),),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.only(topLeft: _radius, bottomLeft: _radius),),
          prefixIcon: widget.config.front != null
              ? Padding(padding: const EdgeInsets.all(8.0),
                  child: widget.config.front,)
              : null),
      onChanged: (str) {
        _text = str;
        if (widget.onChanged != null) widget.onChanged(_text);
      },
      onTap: widget.onTap,
//      onSubmitted: (str) {
//        FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
//        if(widget.config.submitClear){
//          setState(() {_text = "";});
//        }
//      },
    );
    var btn = RaisedButton(
      child: Icon(widget.config.iconData),
      color: Color(0x99E0E0E0),
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
        if (widget.onSubmit != null) widget.onSubmit(_text);
        if(widget.config.submitClear){
          setState(() {_text = "";});
        }
      },
    );
    var inputBtn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: Container(child: textField, height: _height,),),
        ClipRRect(borderRadius: BorderRadius.only(
                    topLeft: Radius.zero, bottomLeft: Radius.zero,
                    topRight: _radius, bottomRight: _radius),
                child: Container(
                  child: btn, width: _height, height: _height,),),
      ],
    );
    return inputBtn;
  }
}
