import 'package:flutter/material.dart';

class YFImageDetailPage extends StatelessWidget {
  final String _imageURL;

  YFImageDetailPage(this._imageURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          child: Hero(tag: _imageURL, child: Image.network(_imageURL)),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
