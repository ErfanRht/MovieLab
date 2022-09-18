import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPageTitle extends StatelessWidget {
  final String title;
  const ItemPageTitle({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
    );
  }
}
