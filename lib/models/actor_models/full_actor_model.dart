// Actor or Actress all details model class
import 'package:movielab/modules/tools/image_quality_increaser.dart';

import '../show_models/show_preview_model.dart';

class FullActor {
  final String id;
  final String name;
  final String image;
  final String role;
  final String summary;
  final String birthDate;
  final String deathDate;
  final String awards;
  final String height;
  final List<ShowPreview> knownFor;

  const FullActor({
    required this.id,
    required this.name,
    required this.image,
    required this.role,
    required this.summary,
    required this.birthDate,
    required this.deathDate,
    required this.awards,
    required this.height,
    required this.knownFor,
  });

  factory FullActor.fromJson(Map<String, dynamic> json) {
    return FullActor(
      id: json['id'],
      name: json['name'] ?? "",
      image: imageQualityIncreaser(json['image']),
      role: json['role'] ?? "",
      summary: json['summary'] ?? "",
      birthDate: json['birthDate'] ?? "",
      deathDate: json['deathDate'] ?? "",
      awards: json['awards'] ?? "",
      height: json['height'] ?? "",
      knownFor: getKnownFor(json: json['knownFor']) ?? [],
    );
  }
}

// Get known for movies or TV shows to an actor or actress from the API
List<ShowPreview>? getKnownFor({required json}) {
  List<ShowPreview> knownFor = [];
  for (int i = 0; i < json.length; i++) {
    json[i]["rank"] = i.toString();
    knownFor.add(ShowPreview.fromJson(json[i]));
  }
  return knownFor;
}
