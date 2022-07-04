import 'package:hive/hive.dart';
import '../hive_helper/fields/show_preview_fields.dart';
import '../hive_helper/hive_adapters.dart';
import '../hive_helper/hive_types.dart';

part 'show_preview.g.dart';

@HiveType(typeId: HiveTypes.showPreview, adapterName: HiveAdapters.showPreview)
class HiveShowPreview extends HiveObject {
  @HiveField(ShowPreviewFields.id)
  late String id;
  @HiveField(ShowPreviewFields.rank)
  late String rank;
  @HiveField(ShowPreviewFields.title)
  late String title;
  @HiveField(ShowPreviewFields.crew)
  late String crew;
  @HiveField(ShowPreviewFields.image)
  late String image;
  @HiveField(ShowPreviewFields.year)
  late String year;
  @HiveField(ShowPreviewFields.imDbRating)
  late String imDbRating;
  @HiveField(ShowPreviewFields.weekend)
  late String weekend;
  @HiveField(ShowPreviewFields.gross)
  late String gross;
  @HiveField(ShowPreviewFields.weeks)
  late String weeks;
  @HiveField(ShowPreviewFields.worldwideLifetimeGross)
  late String worldwideLifetimeGross;
  @HiveField(ShowPreviewFields.domesticLifetimeGross)
  late String domesticLifetimeGross;
  @HiveField(ShowPreviewFields.domestic)
  late String domestic;
  @HiveField(ShowPreviewFields.foreignLifetimeGross)
  late String foreignLifetimeGross;
  @HiveField(ShowPreviewFields.foreign)
  late String foreign;
}
