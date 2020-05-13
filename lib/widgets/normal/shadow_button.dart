import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {
  final Function onClick;
  final String text;
  final int colorCode;

  ShadowButton({this.onClick, this.text, this.colorCode = 0xFF000000});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
//    TODO :: Loading And  signUp user
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: size.height * 0.06,
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
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Color(colorCode),
            ),
          ),
        ),
      ),
    );
  }
}
