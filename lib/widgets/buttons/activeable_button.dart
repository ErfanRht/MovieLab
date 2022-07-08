import 'package:flutter/material.dart';

class ActiveableButton extends StatelessWidget {
  final String text;
  final String? activeText;
  final IconData icon;
  final IconData? activeIcon;
  final VoidCallback onTap;
  final bool isActive;
  final Color backgroundColor;
  final Color? activeColor;
  final EdgeInsets margin;
  const ActiveableButton(
      {Key? key,
      required this.isActive,
      required this.text,
      this.activeText,
      required this.icon,
      this.activeIcon,
      required this.onTap,
      this.activeColor,
      this.margin = const EdgeInsets.symmetric(vertical: 7.5),
      this.backgroundColor = const Color(0xff2a425f)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      margin: margin,
      width: MediaQuery.of(context).size.width - 100,
      decoration: BoxDecoration(
          color: isActive
              ? activeColor?.withOpacity(0.75) ??
                  backgroundColor.withOpacity(0.75)
              : backgroundColor.withOpacity(0.75),
          borderRadius: BorderRadius.circular(15)),
      duration: const Duration(milliseconds: 150),
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Icon(
                  isActive ? activeIcon ?? icon : icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Text(
                isActive ? activeText ?? text : text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
