import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/shared/settings_page/sections/backup_page.dart';
import 'package:movielab/widgets/default_appbar.dart';
import 'package:movielab/widgets/toast.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Scaffold(
      appBar: defaultAppBar(context, title: "Settings"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            settingSection(
                icon: Icons.backup_sharp,
                title: "Offline import/export database",
                description:
                    "Get a backup file of your personal data locally on your phone",
                onPressed: () async {
                  Navigate.pushTo(context, BackupPage());
                }),
            settingSection(
                icon: Icons.cancel_sharp,
                title: "Clear media content cache",
                description:
                    "Remove all cached content, but not your personal data",
                onPressed: () async {
                  await DefaultCacheManager().emptyCache();
                  fToast.removeQueuedCustomToasts();
                  fToast.showToast(
                    child: ToastWidget(
                      mainText: "Cache cleared",
                      buttonText: "Ok",
                      buttonColor: kAccentColor,
                      buttonOnTap: () async {
                        await Future.delayed(const Duration(milliseconds: 200));
                        fToast.removeCustomToast();
                      },
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

Widget settingSection(
    {required final IconData icon,
    double iconSize = 30,
    required final String title,
    required final String description,
    required final void Function() onPressed}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white,
      size: iconSize,
    ),
    title: Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
