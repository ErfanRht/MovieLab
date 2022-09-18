import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/models/user.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/pages/main/profile/sections/user_profile/edit_user_profile.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';

import 'sections/lists.dart';
import 'sections/settings.dart';
import 'sections/socials.dart';
import 'sections/user_profile/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return ValueListenableBuilder<Box<HiveUser>>(
          valueListenable: Hive.box<HiveUser>('user').listenable(),
          builder: (context, box, _) {
            final user = box.values.toList().cast<HiveUser>();
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _buildBody(context,
                  user[0].name != "" && user[0].username != "" ? true : false),
            );
          });
    });
  }
}

Widget _buildBody(BuildContext context, final bool profile) {
  switch (profile) {
    case false:
      return editUserProfileBody(context, isEdit: false);
    default:
      return GetBuilder<MainController>(builder: (__) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kSecondaryColor,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text("Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InefficaciousRefreshIndicator(
              child: ListView(
                controller: __.profileScrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 25),
                  ProfilePageUserProfile(),
                  const SizedBox(height: 40),
                  const ProfilePageLists(),
                  const SizedBox(height: 40),
                  const ProfilePageSettings(),
                  const SizedBox(height: 40),
                  const ProfilePageSocials(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      });
  }
}
