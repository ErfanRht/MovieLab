// A episode of a TV show model class
class Episode {
  final String id;
  final String title;
  final String image;
  final String year;
  final String released;
  final String imDbRating;
  final String imDbVotes;
  final String seasonNumber;
  final String episodeNumber;
  final String plot;

  const Episode({
    required this.id,
    required this.title,
    required this.image,
    required this.year,
    required this.released,
    required this.imDbRating,
    required this.imDbVotes,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.plot,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      title: json['title'] ?? "",
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'] ?? "",
      released: json['released'] ?? "",
      imDbRating: json['imDbRating'] ?? "0.0",
      imDbVotes: json['imDbRatingCount'] ?? "0",
      seasonNumber: json['seasonNumber'] ?? "",
      episodeNumber: json['episodeNumber'] ?? "",
      plot: json['plot'] ?? "",
    );
  }
}
