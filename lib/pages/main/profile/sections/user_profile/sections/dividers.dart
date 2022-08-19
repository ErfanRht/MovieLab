import 'package:flutter/material.dart';

Widget smallDivider() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 24,
      width: 1,
      child: VerticalDivider(
        color: Colors.white.withOpacity(0.75),
        thickness: 1.5,
      ),
    );
Widget bigDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7.5),
      child: Divider(
        color: Colors.white.withOpacity(0.75),
        thickness: 2.5,
      ),
    );
