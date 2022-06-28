import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GmButton extends StatelessWidget {
  const GmButton(
      {Key? key,
      required this.text,
      this.icon,
      required this.onTap,
      this.radius = 10,
      required this.color,
      this.backgroundColor,
      this.height = 35,
      this.width = 100})
      : super(key: key);

  final String text;
  final IconData? icon;
  final Void? Function() onTap;
  final double radius;
  final Color color;
  final Color? backgroundColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor ?? color.withOpacity(0.25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(icon, color: color, size: 15)
                : const SizedBox.shrink(),
            icon != null
                ? const SizedBox(
                    width: 7.5,
                  )
                : const SizedBox.shrink(),
            Text(text,
                style: GoogleFonts.ubuntu(
                    color: color, fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
