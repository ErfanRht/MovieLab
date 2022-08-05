import 'package:hive/hive.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/hive/models/time_of_day.g.dart';

void registerAdapters() {
  Hive.registerAdapter(HiveShowPreviewAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
}
