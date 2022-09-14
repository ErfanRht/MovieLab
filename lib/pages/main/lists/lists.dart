import 'package:flutter/material.dart';
import 'package:movielab/pages/shared/userlist_body.dart';
import 'sections/navbar.dart';

class UserListsPage extends StatelessWidget {
  const UserListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: UserListsNavbar(),
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              UserListBody(listName: "watchlist"),
              UserListBody(listName: "history"),
              UserListBody(listName: "collection")
            ],
          ),
        ));
  }
}
