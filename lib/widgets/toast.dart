import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/profile/sections/list_page/list_page.dart';

class ToastWidget extends StatelessWidget {
  final String mainText;
  final Color mainTextColor;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? buttonOnTap;
  final bool closeOnButtonTap;
  final bool pushOnButtonTap;
  final String listName;
  final double fontSize;
  ToastWidget(
      {Key? key,
      required this.mainText,
      this.mainTextColor = Colors.black,
      this.fontSize = 14,
      required this.buttonText,
      required this.buttonColor,
      this.buttonOnTap,
      this.closeOnButtonTap = false,
      this.pushOnButtonTap = false,
      this.listName = ""})
      : super(key: key);

  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.zero,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.95),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mainText,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: mainTextColor,
                fontSize: fontSize),
          ),
          TextButton(
              onPressed: buttonOnTap ??
                  () async {
                    if (closeOnButtonTap) {
                      await Future.delayed(const Duration(milliseconds: 50))
                          .then((value) {
                        fToast.removeCustomToast();
                      });
                    }
                    if (pushOnButtonTap) {
                      await Future.delayed(const Duration(milliseconds: 50))
                          .then((value) {
                        fToast.removeCustomToast();
                        Navigate.pushHeroicTo(
                            context, ListPage(listName: listName));
                      });
                    }
                  },
              style:
                  TextButton.styleFrom(primary: buttonColor.withOpacity(0.5)),
              child: Text(
                buttonText,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: buttonColor,
                    fontSize: fontSize),
              ))
        ],
      ),
    );
  }
}
