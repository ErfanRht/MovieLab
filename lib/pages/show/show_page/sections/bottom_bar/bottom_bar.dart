import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../constants/colors.dart';

class ShowPageBottonBar extends StatelessWidget {
  const ShowPageBottonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          const SizedBox(
            width: 7.5,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            child: const SizedBox(
              height: 45,
              width: 45,
              child: Icon(
                FontAwesomeIcons.alignLeft,
                size: 22.5,
                color: Colors.white,
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: kSecondaryColor,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    height: 235,
                    child: Column(
                      children: [
                        button(context,
                            icon: FontAwesomeIcons.circle,
                            text: 'Mark as watched'),
                        button(context,
                            icon: FontAwesomeIcons.bookmark,
                            text: 'Add to watchlist'),
                        button(context,
                            icon: FontAwesomeIcons.rectangleList,
                            text: 'Add to collection'),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            width: 7.5,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            child: const SizedBox(
              height: 45,
              width: 45,
              child: Icon(
                FontAwesomeIcons.arrowUpRightFromSquare,
                size: 22.5,
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(
            width: 7.5,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            child: const SizedBox(
              height: 45,
              width: 45,
              child: Icon(
                FontAwesomeIcons.clapperboard,
                size: 22.5,
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(
            width: 7.5,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(30),
            child: const SizedBox(
              height: 45,
              width: 45,
              child: Icon(
                FontAwesomeIcons.ellipsisVertical,
                size: 22.5,
                color: Colors.white,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context,
      {required String text,
      required IconData icon,
      EdgeInsets margin = const EdgeInsets.symmetric(vertical: 7.5)}) {
    return Container(
      height: 50,
      margin: margin,
      width: MediaQuery.of(context).size.width - 100,
      decoration: BoxDecoration(
          color: const Color(0xff2a425f).withOpacity(0.75),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }
}
