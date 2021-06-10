import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/bloc/search/search_bloc.dart';
import '../app/bloc/search/search_event.dart';

class AppSearchBar extends StatefulWidget {
  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  var _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textField = TextField(
      showCursor: true,
      autofocus: false,
      //自动聚焦，闪游标
      controller: _controller,
      maxLines: 1,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Hero(tag: "top_search", child: Icon(Icons.search)),
          contentPadding: EdgeInsets.only(top: 0),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none, //去边线
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          hintText: "搜点啥...",
          hintStyle: TextStyle(fontSize: 14)),

      onChanged: (String str) {
        BlocProvider.of<SearchBloc>(context).add(EventTextChanged(str));
      },
      onEditingComplete: () {
        print("onEditingComplete");
      },
//      onTap: (),
      onSubmitted: (str) {
        FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
        _controller.clear();
      },
    );

    return Container(
        height: 35,
//        width: MediaQuery.of(context).size.width * 0.618,
        child: textField);
  }
}
