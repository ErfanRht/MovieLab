import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movielab/models/user_model/user_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/pages/splash/get_user_data.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';
import 'package:movielab/widgets/textfield_widget.dart';

import 'sections/user_profile_image.dart';

class ProfilePageEditUserProfile extends StatelessWidget {
  const ProfilePageEditUserProfile({Key? key}) : super(key: key);
  Future<bool> _onWillPop() async {
    Get.find<ProfileController>()
        .updateTextFields(nameErrorText: "", usernameErrorText: "");
    getUserInformation();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: editUserProfileBody(context, isEdit: true));
  }
}

Widget editUserProfileBody(BuildContext context, {required final bool isEdit}) {
  return GetBuilder<ProfileController>(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        leading: isEdit ? const BackButton() : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          userProfileImage(context, icon: Icons.add_a_photo, onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image =
                await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              _.updateUserInfo(imageUrl: image.path);
            }
          }),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Name',
            text: _.name,
            errorText: _.nameErrorText,
            onChanged: (name) {
              _.name = name.trim();
            },
            onTap: () {
              _.updateTextFields(nameErrorText: "");
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Username',
            text: _.username,
            errorText: _.usernameErrorText,
            onChanged: (username) {
              _.username = username.trim();
            },
            onTap: () {
              _.updateTextFields(usernameErrorText: "");
            },
          ),
          const SizedBox(height: 40),
          GmButton(
              text: "Save",
              onTap: () {
                PreferencesShareholder preferencesShareholder =
                    PreferencesShareholder();

                if (_.name == "") {
                  _.updateTextFields(
                      nameErrorText: "Name field cannot be empty!");
                }
                if (_.username == "") {
                  _.updateTextFields(
                      usernameErrorText: "Username field cannot be empty!");
                }
                if (_.username != "" && _.name != "") {
                  preferencesShareholder.updateUser(
                      user: User(
                          name: _.name,
                          username: _.username,
                          imageUrl: _.imageUrl));
                  _.updateUserInfo(
                      name: _.name, username: _.username, imageUrl: _.imageUrl);
                  if (isEdit) {
                    Navigator.pop(context);
                  }
                }
              },
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5),
              backgroundColor: Colors.blue,
              color: Colors.white)
        ],
      ),
    );
  });
}
