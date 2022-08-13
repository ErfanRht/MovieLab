import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';

Widget userProfileImage(BuildContext context,
        {required IconData icon, void Function()? onTap}) =>
    Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: const AssetImage("assets/images/no_picture.png"),
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(onTap: () {}),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: InkWell(
              onTap: onTap,
              child: buildCircle(
                color: kSecondaryColor,
                all: 3,
                child: buildCircle(
                  color: Colors.blue,
                  all: 8,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
