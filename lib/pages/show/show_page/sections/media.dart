import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

import '../../../actor/actor_page/sections/section_title.dart';

class ShowPageMedia extends StatelessWidget {
  final List images;
  const ShowPageMedia({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: "Media"),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              mediaButton(
                  text: "Posters",
                  onTap: () {
                    return null;
                  },
                  color: kSecondaryColor,
                  icon: FontAwesomeIcons.blog),
              const SizedBox(
                width: 10,
              ),
              mediaButton(
                  text: "Images",
                  onTap: () {
                    return null;
                  },
                  color: kPrimaryColor,
                  icon: FontAwesomeIcons.solidImages),
              const SizedBox(
                width: 10,
              ),
              mediaButton(
                  text: "Trailers",
                  onTap: () {
                    return null;
                  },
                  color: kGreyColor,
                  icon: FontAwesomeIcons.compactDisc)
            ],
          ),
        ),
      ],
    );
  }
}

Widget mediaButton(
    {required final String text,
    final IconData? icon,
    required final Void? Function() onTap,
    final double radius = 10,
    required final Color color,
    final double height = 35,
    final double width = 100}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(radius),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color.withOpacity(0.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Icon(icon, color: color, size: 15)
              : const SizedBox.shrink(),
          icon != null
              ? const SizedBox(
                  width: 7.5,
                )
              : const SizedBox.shrink(),
          Text(text,
              style: GoogleFonts.ubuntu(
                  color: color, fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    ),
  );
}
