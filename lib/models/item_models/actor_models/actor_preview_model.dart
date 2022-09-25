// Actor or actress preview model class
import 'dart:convert';

import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/tools/image_quality_increaser.dart';

class ActorPreview {
  final String id;
  final String name;
  final String image;
  final String asCharacter;
  final List<ShowPreview>? knownFor;
  final String? birthDate;
  final String? deathDate;
  final String? height;

  const ActorPreview({
    required this.id,
    required this.name,
    required this.image,
    required this.asCharacter,
    this.knownFor,
    this.birthDate,
    this.deathDate,
    this.height,
  });

  factory ActorPreview.fromJson(Map<String, dynamic> json) {
    return ActorPreview(
      id: json['id'],
      name: json['name'],
      image: imageQualityIncreaser(json['image']),
      asCharacter: json['asCharacter'] ?? "",
    );
  }

  static Map<String, dynamic> toMap(ActorPreview actor) => {
        'id': actor.id,
        'name': actor.name,
        'image': actor.image,
        'asCharacter': actor.asCharacter,
      };

  static String encode(List<ActorPreview> actors) => json.encode(
        actors
            .map<Map<String, dynamic>>((actor) => ActorPreview.toMap(actor))
            .toList(),
      );

  static List<ActorPreview> decode(String actors) =>
      (json.decode(actors) as List<dynamic>)
          .map<ActorPreview>((item) => ActorPreview.fromJson(item))
          .toList();
}
