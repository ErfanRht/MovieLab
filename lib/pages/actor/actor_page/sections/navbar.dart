import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/preferences_shareholder.dart';

class ActorPageNavBar extends StatefulWidget {
  FullActor? actor;
  //bool isBookmarked;
  ActorPageNavBar({
    Key? key,
    required this.actor,
    /* required this.isBookmarked */
  }) : super(key: key);

  @override
  State<ActorPageNavBar> createState() => _ActorPageNavBarState();
}

class _ActorPageNavBarState extends State<ActorPageNavBar> {
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    // isFavorite = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {
                isFavorite
                    ? {
                        setState(() {
                          isFavorite = false;
                        })
                      }
                    : {
                        setState(() {
                          isFavorite = true;
                        })
                      };
              },
              icon: Icon(
                isFavorite
                    ? FontAwesomeIcons.heart
                    : FontAwesomeIcons.solidHeart,
                color: kPrimaryColor,
                size: 27.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
