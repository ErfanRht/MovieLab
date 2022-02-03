class Show {
  final String id;
  final String rank;
  final String title;
  final String fullTitle;
  final String crew;
  final String image;
  final String year;
  final String imDbRating;

  const Show({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.crew,
    required this.image,
    required this.year,
    required this.imDbRating,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      rank: json['rank'],
      title: json['title'],
      fullTitle: json['fullTitle'],
      crew: json['crew'],
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'],
      imDbRating: json['imDbRating'],
    );
  }
}
