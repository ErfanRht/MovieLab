import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';
import 'package:movielab/widgets/textfield_widget.dart';

import 'user_profile_image.dart';

class ProfilePageEditUserProfile extends StatelessWidget {
  const ProfilePageEditUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          userProfileImage(context, icon: Icons.add_a_photo, onTap: () {}),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: "user.name",
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: "user.email",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: "user.about",
            maxLines: 5,
            onChanged: (about) {},
          ),
          const SizedBox(height: 40),
          GmButton(
              text: "Save",
              onTap: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5),
              backgroundColor: Colors.blue,
              color: Colors.white)
        ],
      ),
    );
  }
}
