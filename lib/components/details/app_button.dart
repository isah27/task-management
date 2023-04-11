import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.size,
    this.bgColor = Colors.amber,
    this.textColor = Colors.white,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final String text;
  final Color textColor;
  final Color bgColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.width * 0.05),
      child: MaterialButton(
        color: bgColor,
        minWidth: size.width * 0.9,
        padding: EdgeInsets.all(size.height * 0.014),
        onPressed: () => onTap(),
        child: AppText(
          text: text,
          size: 14.sp,
          textColor: textColor,
        ),
      ),
    );
  }
}
