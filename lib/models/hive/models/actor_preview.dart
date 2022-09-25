import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movielab/models/hive/hive_helper/fields/actor_preview_fields.dart';
import 'package:movielab/models/hive/hive_helper/hive_adapters.dart';
import 'package:movielab/models/hive/hive_helper/hive_types.dart';
import 'show_preview.dart';

part 'actor_preview.g.dart';

@HiveType(
    typeId: HiveTypes.actorPreview, adapterName: HiveAdapters.actorPreview)
class HiveActorPreview extends HiveObject {
  @HiveField(ActorPreviewFields.id)
  final String id;
  @HiveField(ActorPreviewFields.name)
  final String name;
  @HiveField(ActorPreviewFields.image)
  final String image;
  @HiveField(ActorPreviewFields.asCharacter)
  final String asCharacter;
  @HiveField(ActorPreviewFields.knownFor)
  final List<HiveShowPreview> knownFor;
  @HiveField(ActorPreviewFields.birthDate)
  final String birthDate;
  @HiveField(ActorPreviewFields.deathDate)
  final String deathDate;
  @HiveField(ActorPreviewFields.height)
  final String height;

  HiveActorPreview(
      {required this.id,
      required this.name,
      required this.image,
      required this.asCharacter,
      required this.knownFor,
      required this.height,
      required this.birthDate,
      required this.deathDate});
}
