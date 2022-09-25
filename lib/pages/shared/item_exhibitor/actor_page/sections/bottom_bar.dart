import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/models/item_models/actor_models/full_actor_model.dart';
import 'package:share_plus/share_plus.dart';

class ActorPageBottomBar extends StatelessWidget {
  final FullActor actor;
  ActorPageBottomBar({
    Key? key,
    required this.actor,
  }) : super(key: key);
  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
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
                FontAwesomeIcons.share,
                size: 22.5,
              ),
            ),
            onTap: () {
              Share.share(
                  'Check out this artists!\nhttps://www.imdb.com/title/${actor.id}');
            },
          ),
        ],
      ),
    );
  }
}
