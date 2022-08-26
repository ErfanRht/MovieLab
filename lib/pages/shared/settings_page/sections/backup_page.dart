import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/preferences/backup.dart';
import 'package:movielab/widgets/default_appbar.dart';
import 'package:movielab/widgets/toast.dart';

import '../settings_page.dart';

class BackupPage extends StatelessWidget {
  BackupPage({Key? key}) : super(key: key);
  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Scaffold(
      appBar: defaultAppBar(context, title: "Backup"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            settingSection(
                icon: Icons.cloud_download_rounded,
                iconSize: 30,
                title: "Export backup file",
                description:
                    "You can export the entire database for keeping a backup or to import it in a new device.\nAfter exporting, it's recommended to upload this backup file to a cloud server like Google Drive.",
                onPressed: () async {
                  await createBackup().then((final bool success) {
                    if (success) {
                      fToast.removeQueuedCustomToasts();
                      fToast.showToast(
                        child: ToastWidget(
                          mainText: "The backup file successfully created.",
                          buttonText: "Ok",
                          buttonColor: kAccentColor,
                          buttonOnTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            fToast.removeCustomToast();
                          },
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );
                    }
                  });
                }),
            settingSection(
                icon: Icons.cloud_upload_rounded,
                iconSize: 30,
                title: "Import backup file",
                description:
                    "Select the exported movielab-backup-date.db from file manager.",
                onPressed: () async {
                  await restoreBackup().then((final bool success) async {
                    fToast.removeQueuedCustomToasts();
                    fToast.showToast(
                      child: ToastWidget(
                        mainText: success
                            ? "The backup file imported successfully."
                            : "There's a problem with the imported file!",
                        mainTextColor: success ? Colors.green : kPrimaryColor,
                        buttonText: "Ok",
                        fontSize: 13,
                        buttonColor: Colors.black,
                        buttonOnTap: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          fToast.removeCustomToast();
                        },
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }
}
