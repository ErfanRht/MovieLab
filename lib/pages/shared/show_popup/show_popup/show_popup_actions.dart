import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/pages/shared/show_popup/lists_popup/show_list_popup_actions.dart';

class ShowPopupActions extends StatefulWidget {
  final ShowPreview show;
  final Future<dynamic> Function() updateStats;
  final Color backgroundColor;
  const ShowPopupActions(
      {Key? key,
      required this.show,
      required this.updateStats,
      required this.backgroundColor})
      : super(key: key);

  @override
  State<ShowPopupActions> createState() => _ShowPopupActionsState();
}

class _ShowPopupActionsState extends State<ShowPopupActions>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 20),
      color: widget.backgroundColor,
      height: 350,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: const EdgeInsets.only(top: 20, bottom: 15),
            height: 3,
            color: Colors.white.withOpacity(0.4),
          ),
          button(
              onPressed: () async {
                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 320));
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    transitionAnimationController: AnimationController(
                        duration: const Duration(milliseconds: 250),
                        vsync: this),
                    builder: (context) {
                      return ShowListPopupActions(
                        fullShow: null,
                        updateStats: widget.updateStats,
                        backgroundColor: widget.backgroundColor,
                        show: widget.show,
                      );
                    });
              },
              icon: FontAwesomeIcons.alignLeft,
              text: "Add to lists"),
          button(
              onPressed: () async {
                Navigator.pop(context);
                await Future.delayed(const Duration(milliseconds: 320));
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    transitionAnimationController: AnimationController(
                        duration: const Duration(milliseconds: 250),
                        vsync: this),
                    builder: (context) {
                      return ShowListPopupActions(
                        fullShow: null,
                        updateStats: widget.updateStats,
                        backgroundColor: widget.backgroundColor,
                        show: widget.show,
                      );
                    });
              },
              icon: FontAwesomeIcons.alignLeft,
              text: "Add to lists")
        ],
      ),
    );
  }
}

Widget button(
    {required void Function() onPressed,
    required final IconData icon,
    required final String text}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        )
      ],
    ),
  );
}
