class MovieBox {
  final String id;
  final String rank;
  final String title;
  final String fullTitle;
  final String crew;
  final String image;
  final String year;
  final String imDbRating;

  const MovieBox({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.crew,
    required this.image,
    required this.year,
    required this.imDbRating,
  });

  factory MovieBox.fromJson(Map<String, dynamic> json) {
    return MovieBox(
      id: json['id'],
      rank: json['rank'],
      title: json['title'],
      fullTitle: json['fullTitle'],
      crew: json['crew'],
      image: json['image'],
      year: json['year'],
      imDbRating: json['imDbRating'],
    );
  }
}
