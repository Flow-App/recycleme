import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final double padding;
  final bool hidden;
  final Function onChanged;

  InputField({this.hint, this.onChanged, this.padding, this.hidden = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color(0xffEBEBEB),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            obscureText: hidden,
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
