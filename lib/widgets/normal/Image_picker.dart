import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function onImageChanged;

  ImagePickerWidget({this.onImageChanged});

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerWidget> {
  Widget _imageWidget;
  File image;

  @override
  Widget build(BuildContext context) {
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
            child: image == null
                ? Padding(
                    padding: EdgeInsets.all(30),
                    child: Icon(
                      FontAwesomeIcons.plus,
                      size: 40,
                      color: const Color(0xFF9ABBFF),
                    ),
                  )
                : _imageWidget),
      ),
    );
  }
}
