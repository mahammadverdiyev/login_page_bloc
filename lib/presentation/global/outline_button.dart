import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? bgColor;
  final Color? primaryColor;
  const CustomOutlinedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.primaryColor = Colors.white,
      this.bgColor = const Color(0xff9450e7)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: bgColor,
            primary: primaryColor,
            fixedSize: new Size(0, 45),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(12),
            )),
        onPressed: onPressed,
        child: new Text("$text"));
  }
}
