import 'package:flutter/material.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/profile/sections/user_stats/user_stats.dart';

Widget statsBox(BuildContext context,
        {required final String? value,
        required final String text,
        final double? width,
        final int sizeType = 1}) =>
    SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.25,
      child: TextButton(
        onPressed: () {
          Navigate.pushTo(context, const UserStatsPage());
        },
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
                value!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
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
      ),
    );
