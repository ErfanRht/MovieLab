import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Movie',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        children: <TextSpan>[
          TextSpan(text: 'Lab', style: TextStyle(color: kPrimaryColor)),
        ],
      ),
    );
  }
}
