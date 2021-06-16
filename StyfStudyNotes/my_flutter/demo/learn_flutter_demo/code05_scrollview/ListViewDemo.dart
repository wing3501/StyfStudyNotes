import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: ListView.separated(
                itemBuilder: (BuildContext ctx, int index) {
                  return Text("hello world");
                },
                separatorBuilder: (BuildContext ctx, int index) {
                  return Divider(
                    color: Colors.red,
                    height: 50, //所在区域高度
                    indent: 30,
                    endIndent: 20,
                    thickness: 10, //线高度
                  );
                },
                itemCount: 50),
          ),
        ),
      ),
    );
  }

  ListView buildListView2() {
    return ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext ctx, int index) {
          return Text("hello world");
        });
  }

  ListView buildListView1() {
    return ListView(
      scrollDirection: Axis.vertical,
      itemExtent: 100, //不设就是默认高度
      // reverse: true,
      primary: true, //是否关联controller
      children: List.generate(100, (index) {
        // return Text("hello-$index");

        return ListTile(
          leading: Icon(Icons.people),
          trailing: Icon(Icons.delete),
          title: Text("联系人$index"),
          subtitle: Text("号码：15088627777"),
        );
      }),
    );
  }
}
