import 'package:flutter/material.dart';

class YFSubjectContent extends StatefulWidget {
  @override
  _YFSubjectContentState createState() => _YFSubjectContentState();
}

class _YFSubjectContentState extends State<YFSubjectContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('书影音'),
      ),
      body: Text("书影音"),
    );
  }
}
