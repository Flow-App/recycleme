import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function onImageChanged;
  final String userPic;

  ImagePickerWidget({this.onImageChanged, this.userPic});

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  File image;
  Widget _imageWidget;

  @override
  Widget build(BuildContext context) {
    if (widget.userPic == null) {
      _imageWidget = SizedBox();
    } else {
      _imageWidget = Image.network(
        widget.userPic,
        fit: BoxFit.fill,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () async {
          image = await ImagePicker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() {
              _imageWidget = Image.file(
                image,
                fit: BoxFit.fill,
              );
              widget.onImageChanged(image);
            });
          }
        },
        child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: const Color(0xffEBEBEB),
              ),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                  color: Color(0XFFadd5f7),
                  offset: const Offset(0.0, 0.0),
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: _imageWidget),
      ),
    );
  }
}
