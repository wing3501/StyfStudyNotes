import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        // home:SafeArea()
        home: Scaffold(
            // appBar: AppBar(
            //   title: Text('Material App Bar'),
            // ),
            body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("哈哈哈"),
                background: Image.asset(
                  "assets/images/3.0x/1.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              pinned: true,
            ),
            SliverGrid(
                delegate:
                    SliverChildBuilderDelegate((BuildContext ctx, int index) {
                  return Container(
                    color: Color.fromARGB(255, Random().nextInt(256),
                        Random().nextInt(256), Random().nextInt(256)),
                  );
                }, childCount: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.5)),
            SliverList(delegate:
                SliverChildBuilderDelegate((BuildContext btx, int index) {
              return ListTile(
                leading: Icon(Icons.people),
                title: Text("联系人$index"),
              );
            }))
          ],
        )));
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverPadding(
              //解决padding不能顶部条问题
              padding: EdgeInsets.all(8),
              sliver: SliverGrid(
                  delegate:
                      SliverChildBuilderDelegate((BuildContext ctx, int index) {
                    return Container(
                      color: Color.fromARGB(255, Random().nextInt(256),
                          Random().nextInt(256), Random().nextInt(256)),
                    );
                  }, childCount: 100),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.5))),
        )
      ],
    );
  }

  Container buildSliver() {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverSafeArea(
              //解决顶部的安全区域
              sliver: SliverGrid(
                  delegate:
                      SliverChildBuilderDelegate((BuildContext ctx, int index) {
                    return Container(
                      color: Color.fromARGB(255, Random().nextInt(256),
                          Random().nextInt(256), Random().nextInt(256)),
                    );
                  }, childCount: 100),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.5)))
        ],
      ),
    );
  }
}
