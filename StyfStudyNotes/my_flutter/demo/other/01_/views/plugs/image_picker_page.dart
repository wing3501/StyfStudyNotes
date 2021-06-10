import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../widget_demo/circle_image_demo.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: InkWell(
          onTap: _getGalleryImage,
          child: CircleImage(
              size: 100,
              image: _image == null
                  ? AssetImage("assets/images/default_image.png")
                  : FileImage(_image)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCameraImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  _getCameraImage() async {
    //从相机获取图片
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() => _image = File(pickedFile.path));
  }

  _getGalleryImage() async {
    //从相册获取图片
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() => _image = File(pickedFile.path));
  }
}
