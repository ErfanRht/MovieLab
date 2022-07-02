// Actor or actress preview model class
import 'dart:convert';

class ActorPreview {
  final String id;
  final String name;
  final String image;
  final String asCharacter;

  const ActorPreview({
    required this.id,
    required this.name,
    required this.image,
    required this.asCharacter,
  });

  factory ActorPreview.fromJson(Map<String, dynamic> json) {
    return ActorPreview(
      id: json['id'],
      name: json['name'],
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
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
