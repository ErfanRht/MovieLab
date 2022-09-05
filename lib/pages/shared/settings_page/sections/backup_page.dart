import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/preferences/backup.dart';
import 'package:movielab/widgets/default_appbar.dart';
import 'package:movielab/widgets/guide_modal.dart';
import 'package:movielab/widgets/toast.dart';

import '../settings_page.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({Key? key}) : super(key: key);

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> with TickerProviderStateMixin {
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
                    "You can export the entire database for keeping a backup or to import it in a new device\nAfter exporting, it's recommended to upload this backup file to a cloud server like Google Drive",
                onPressed: () async {
                  guideModalSheet(context,
                      vsync: this,
                      title: "Select File Location",
                      decription:
                          "Select the directory where you want to save this file.",
                      buttonText: "Select Folder", onTap: () async {
                    await createBackup().then((final bool success) {
                      if (success) {
                        fToast.removeQueuedCustomToasts();
                        fToast.showToast(
                          child: ToastWidget(
                            mainText: "The backup file successfully created.",
                            buttonText: "Ok",
                            buttonColor: kAccentColor,
                            closeOnButtonTap: true,
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 2),
                        );
                      } else {
                        fToast.removeQueuedCustomToasts();
                        fToast.showToast(
                          child: ToastWidget(
                            mainText: "Something went wrong!",
                            buttonText: "Ok",
                            buttonColor: kPrimaryColor,
                            closeOnButtonTap: true,
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 2),
                        );
                      }
                    });
                    Navigator.pop(context);
                  });
                }),
            settingSection(
                icon: Icons.cloud_upload_rounded,
                iconSize: 30,
                title: "Import backup file",
                description:
                    "Select the exported movielab-backup-date.db from file manager",
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
                        closeOnButtonTap: true,
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
