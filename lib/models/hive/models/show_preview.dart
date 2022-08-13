import 'package:flutter/material.dart';
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
  @HiveField(ShowPreviewFields.type)
  late String type;
  @HiveField(ShowPreviewFields.crew)
  late String crew;
  @HiveField(ShowPreviewFields.image)
  late String image;
  @HiveField(ShowPreviewFields.year)
  late String year;
  @HiveField(ShowPreviewFields.imDbRating)
  late String imDbRating;
  @HiveField(ShowPreviewFields.genres)
  late String genres;
  @HiveField(ShowPreviewFields.countries)
  late String countries;
  @HiveField(ShowPreviewFields.languages)
  late String languages;
  @HiveField(ShowPreviewFields.companies)
  late String companies;
  @HiveField(ShowPreviewFields.contentRating)
  late String contentRating;
  @HiveField(ShowPreviewFields.similars)
  late List<HiveShowPreview> similars;
  @HiveField(ShowPreviewFields.watchDate)
  DateTime? watchDate;
  @HiveField(ShowPreviewFields.watchTime)
  TimeOfDay? watchTime;
}
