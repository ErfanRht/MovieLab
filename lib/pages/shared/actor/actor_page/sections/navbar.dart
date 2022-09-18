import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/actor_models/full_actor_model.dart';

class ActorPageNavBar extends StatefulWidget {
  final FullActor? actor;
  const ActorPageNavBar({
    Key? key,
    required this.actor,
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
