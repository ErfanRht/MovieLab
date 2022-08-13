import 'package:flutter/material.dart';

Widget statsBox(BuildContext context,
        {required final String value,
        required final String text,
        final int sizeType = 1}) =>
    TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: sizeType == 2 ? 18 : 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
