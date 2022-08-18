import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActorPageMainInfo extends StatelessWidget {
  final String role;
  const ActorPageMainInfo({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(role,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
