import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/pages/main/profile/sections/user_profile/edit_user_profile.dart';

import 'sections/lists.dart';
import 'sections/settings.dart';
import 'sections/socials.dart';
import 'sections/user_profile/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _buildBody(_.name),
      );
    });
  }
}

_buildBody(final String name) {
  switch (name) {
    case "Your name":
      return const ProfilePageEditUserProfile();
    default:
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              SizedBox(height: 25),
              ProfilePageUserProfile(),
              SizedBox(height: 40),
              ProfilePageLists(),
              SizedBox(height: 40),
              ProfilePageSettings(),
              SizedBox(height: 40),
              ProfilePageSocials(),
              SizedBox(height: 40),
            ],
          ),
        ),
      );
  }
}
