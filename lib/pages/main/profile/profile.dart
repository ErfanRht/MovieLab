import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sections/lists.dart';
import 'sections/settings.dart';
import 'sections/socials.dart';
import 'sections/user_profile/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
