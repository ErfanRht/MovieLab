import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsets padding;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const SectionTitle(
      {Key? key,
      required this.title,
      this.fontSize = 19,
      this.fontWeight = FontWeight.w500,
      this.padding = const EdgeInsets.only(left: 10, right: 10, bottom: 12.5),
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: padding,
          child: Text(title,
              style: TextStyle(
                  color: color, fontSize: fontSize, fontWeight: fontWeight)),
        ),
      ],
    );
  }
}
