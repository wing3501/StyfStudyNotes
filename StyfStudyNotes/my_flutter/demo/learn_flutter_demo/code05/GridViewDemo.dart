import 'dart:math';

import 'package:flutter/material.dart';

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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            // child: GridView.extent(maxCrossAxisExtent: maxCrossAxisExtent),
            // child: GridView.count(crossAxisCount: crossAxisCount),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    color: Color.fromARGB(255, Random().nextInt(256),
                        Random().nextInt(256), Random().nextInt(256)),
                  );
                }),
          )),
    );
  }

  Padding buildGridView2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120, crossAxisSpacing: 8, mainAxisSpacing: 8),
        children: List.generate(100, (index) {
          return Container(
            color: Color.fromARGB(255, Random().nextInt(256),
                Random().nextInt(256), Random().nextInt(256)),
          );
        }),
      ),
    );
  }

  Padding buildGridView1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing:
                8), //必传 //SliverGridDelegateWithFixedCrossAxisCount 交叉轴个数
        //childAspectRatio 宽度除以高度比
        children: List.generate(100, (index) {
          return Container(
            color: Color.fromARGB(255, Random().nextInt(256),
                Random().nextInt(256), Random().nextInt(256)),
          );
        }),
      ),
    );
  }
}
