import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ActiveableButton extends StatelessWidget {
  final String text;
  final String? activeText;
  final IconData? icon;
  final IconData? activeIcon;
  final VoidCallback onTap;
  final bool isActive;
  final Color backgroundColor;
  final Color? activeColor;
  final EdgeInsets margin;
  ActiveableButton(
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
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
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
        child: !tapped
            ? TextButton(
                onPressed: () {
                  setState(() {
                    tapped = true;
                  });
                  onTap();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: icon != null
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: [
                    icon != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Icon(
                              isActive ? activeIcon ?? icon : icon,
                              size: 20,
                            ),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      isActive ? activeText ?? text : text,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                  ],
                ))
            : const SpinKitThreeBounce(
                color: Colors.white,
                size: 20.0,
              ),
      );
    });
  }
}
