import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import '../app/bloc/search/search_bloc.dart';
//import '../app/bloc/search/search_event.dart';

class AppSearchBar extends StatefulWidget {
  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  var _controller=TextEditingController();//文本控制器

  @override
  Widget build(BuildContext context) => Container(
        height: 35,
        child:
        TextField(
          style: TextStyle(textBaseline: TextBaseline.alphabetic),
//          autofocus: true, //自动聚焦，闪游标
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(//输入框装饰
              filled: true,//填满
              fillColor: Colors.white,//白色
              prefixIcon:  Icon(Icons.search),//前标
              contentPadding: EdgeInsets.only(top: 7),//调整文字边距
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,//去边线
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              hintText: "搜点啥...",//提示
              hintStyle: TextStyle(fontSize: 14)//提示样式
          ),
//          onChanged: (str) => BlocProvider.of<SearchBloc>(context).add(EventTextChanged(str)),

          onSubmitted: (str) {//提交后
            FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
            _controller.clear();
          },
        ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
