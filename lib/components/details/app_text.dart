import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    required this.text,
    this.size = 12,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  final String text;
  final double size;
  final Color textColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}