import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/user_model/user_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'package:movielab/widgets/textfield_widget.dart';

import 'sections/lists.dart';
import 'sections/settings.dart';
import 'sections/socials.dart';
import 'sections/user_profile/sections/user_profile_image.dart';
import 'sections/user_profile/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
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
          ),
        );
      });
    });
  }
}

Widget _buildBody(BuildContext context, final String name) {
  switch (name) {
    case "Your name":
      return GetBuilder<ProfileController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              userProfileImage(context, icon: Icons.add_a_photo,
                  onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  _.updateUserInfo(imageUrl: image.path);
                }
              }),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: _.name,
                onChanged: (name) {
                  _.name = name;
                },
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Username',
                text: _.username,
                onChanged: (username) {
                  _.username = username;
                },
              ),
              const SizedBox(height: 40),
              GmButton(
                  text: "Save",
                  onTap: () {
                    PreferencesShareholder preferencesShareholder =
                        PreferencesShareholder();
                    preferencesShareholder.updateUser(
                        user: User(
                            name: _.name,
                            username: _.username,
                            imageUrl: _.imageUrl));
                    _.updateUserInfo(
                        name: _.name,
                        username: _.username,
                        imageUrl: _.imageUrl);
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 5),
                  backgroundColor: Colors.blue,
                  color: Colors.white)
            ],
          ),
        );
      });
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
