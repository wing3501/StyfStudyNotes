import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

final eventbus = EventBus();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            primaryColor: Colors.green,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        home: YFHomePage());
  }
}

class YFHomePage extends StatefulWidget {
  @override
  _YFHomePageState createState() => _YFHomePageState();
}

class _YFHomePageState extends State<YFHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: Center(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 16 / 9.0),
          children: List.generate(20, (index) {
            final imageURL = "https://picsum.photos/500/500?random=$index";
            return GestureDetector(
              child: Hero(
                tag: imageURL,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: YFImageDetailPage(imageURL),
                    );
                  },
                ));
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.pool),
        onPressed: () {},
      ),
    );
  }
}
