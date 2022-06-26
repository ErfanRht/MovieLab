import 'package:flutter/material.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';
import 'package:page_transition/page_transition.dart';

import '../../../modules/navigate.dart';

openShowPage(BuildContext context, String id) {
  Navigate.pushTo(context, ShowPage(id: id));
}
