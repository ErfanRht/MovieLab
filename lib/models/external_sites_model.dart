// Movie or TV show as result of a search model class
class ExternalSites {
  final String officialWebsite;
  final String imDb;
  final String theMovieDb;
  final String rottenTomatoes;
  final String metacritic;
  final String netflix;
  final String googlePlay;
  final String filmAffinity;
  final String freebase;
  final String wikipedia;

  const ExternalSites({
    required this.officialWebsite,
    required this.imDb,
    required this.theMovieDb,
    required this.rottenTomatoes,
    required this.metacritic,
    required this.netflix,
    required this.googlePlay,
    required this.filmAffinity,
    required this.freebase,
    required this.wikipedia,
  });

  factory ExternalSites.fromJson(Map<String, dynamic> json) {
    return ExternalSites(
      officialWebsite: json['officialWebsite'] ?? '',
      imDb: json['imDb']?['url'] ?? '',
      theMovieDb: json['theMovieDb']?['url'] ?? '',
      rottenTomatoes: json['rottenTomatoes']?['url'] ?? '',
      metacritic: json['metacritic']?['url'] ?? '',
      netflix: json['netflix']?['url'] ?? '',
      googlePlay: json['googlePlay']?['url'] ?? '',
      filmAffinity: json['filmAffinity']?['url'] ?? '',
      freebase: json['freebase']?['url'] ?? '',
      wikipedia: json['wikipediaUrls']?[0]?['url'] ?? '',
    );
  }
}

List<Map<String, String>> externalSitesList = [
  {'title': "HomePage", 'imgUrl': ""},
  {'title': "IMDb", 'imgUrl': "assets/images/logos/IMDb.png"},
  {'title': "TMDb", 'imgUrl': "assets/images/logos/TMDb.png"},
  {
    'title': "Rotten Tomatoes",
    'imgUrl': "assets/images/logos/RottenTomatoes.png"
  },
  {'title': "Metacritic", 'imgUrl': "assets/images/logos/Metacritic.png"},
  {'title': "Netflix", 'imgUrl': "assets/images/logos/Netflix.png"},
  {'title': "Google Play", 'imgUrl': "assets/images/logos/GooglePlay.png"},
  {'title': "Film Affinity", 'imgUrl': "assets/images/logos/FilmAffinity.png"},
  {'title': "Freebase", 'imgUrl': "assets/images/logos/Freebase.png"},
  {'title': "Wikipedia", 'imgUrl': "assets/images/logos/Wikipedia.png"},
];
