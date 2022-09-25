import 'package:hive/hive.dart';
import 'package:movielab/models/hive/models/actor_preview.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/hive/models/time_of_day.g.dart';
import 'package:movielab/models/hive/models/user.dart';

void registerAdapters() {
  Hive.registerAdapter(ShowPreviewAdapter());
  Hive.registerAdapter(ActorPreviewAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
}
