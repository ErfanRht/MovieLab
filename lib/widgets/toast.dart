import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String mainText;
  final Color mainTextColor;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback buttonOnTap;
  final double fontSize;
  const ToastWidget(
      {Key? key,
      required this.mainText,
      this.mainTextColor = Colors.black,
      this.fontSize = 14,
      required this.buttonText,
      required this.buttonColor,
      required this.buttonOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.zero,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.95),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mainText,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: mainTextColor,
                fontSize: fontSize),
          ),
          TextButton(
              onPressed: buttonOnTap,
              style:
                  TextButton.styleFrom(primary: buttonColor.withOpacity(0.5)),
              child: Text(
                buttonText,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: buttonColor,
                    fontSize: fontSize),
              ))
        ],
      ),
    );
  }
}
