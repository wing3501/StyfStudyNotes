import 'package:flutter/material.dart';
import 'package:my_flutter/module/home/model/int_size.dart';

class PuBuItem extends StatelessWidget {
  final int index;
  final IntSize size;

  const PuBuItem({Key key, this.index, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        FadeInImage(
          placeholder: AssetImage("assets/images/note_cover.jpg"),
          image: NetworkImage(
              "https://picsum.photos/${size.width}/${size.height}/"),
          // fadeOutDuration: Duration(milliseconds: 500),
          // fadeInDuration: Duration(milliseconds: 500),
          height: size.height.toDouble(),
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Image number $index',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Width: ${size.width}',
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                'Height: ${size.height}',
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    ));
  }
}
