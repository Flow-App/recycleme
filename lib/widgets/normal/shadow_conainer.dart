import 'package:flutter/material.dart';

// ignore: camel_case_types
class shadowContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  shadowContainer({this.child, this.padding = const EdgeInsets.all(0) });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xffEBEBEB),
            ),
            borderRadius: BorderRadius.all(
                Radius.circular(16.0) //         <--- border radius here
            ),
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
          child: child),
    );
  }
}
