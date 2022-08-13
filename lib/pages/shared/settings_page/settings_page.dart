import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/widgets/default_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: defaultAppBar(context, title: "Settings"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            settingSection(
                icon: FontAwesomeIcons.xmark,
                title: "Clear media content cache",
                description:
                    "Remove all cached content, but not your personal data",
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

Widget settingSection(
    {required final IconData icon,
    required final String title,
    required final String description,
    required final void Function() onPressed}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white,
    ),
    title: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
      ),
    ),
    subtitle: Text(
      description,
      style: TextStyle(
          fontSize: 15,
          color: Colors.white.withOpacity(0.5),
          fontWeight: FontWeight.w700),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    onTap: onPressed,
  );
}
