import 'package:hive/hive.dart';
import '../models/show_preview.dart';

void registerAdapters() {
  Hive.registerAdapter(HiveShowPreviewAdapter());
}
