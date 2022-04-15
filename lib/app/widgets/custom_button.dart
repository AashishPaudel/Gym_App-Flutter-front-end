import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double radius;

  const CustomButton(
      {Key key,
      @required this.onPressed,
      this.textColor = Colors.white,
      @required this.text,
      this.radius = 15,
      this.backgroundColor = const Color(0xff004252)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(16),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        )),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Get.textTheme.bodyText2.copyWith(
            color: textColor, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
