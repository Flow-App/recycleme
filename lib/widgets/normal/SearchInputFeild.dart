import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final String hint;
  final double padding;
   final Function onChanged;
  final Function onComplete;
  final TextEditingController controller;
  SearchInputField({this.controller,this.hint, this.onChanged, this.padding ,this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: const Color(0xffEBEBEB) ,  ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            onEditingComplete: onComplete,
            autofocus: false,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
