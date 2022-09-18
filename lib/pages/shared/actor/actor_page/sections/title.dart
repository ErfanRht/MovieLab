import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActorPageTitle extends StatelessWidget {
  final String name;
  const ActorPageTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
    );
  }
}
