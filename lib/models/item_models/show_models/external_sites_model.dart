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

List<Map> externalSitesList = [
  {
    'title': "HomePage",
    'imgUrl': "assets/images/logos/Chrome.png",
    'color': 0xffF4F4F4,
    'padding': 5.0
  },
  {
    'title': "IMDb",
    'imgUrl': "assets/images/logos/IMDb.png",
    'color': 0xffE6B91E,
    'padding': 0.0
  },
  {
    'title': "TMDb",
    'imgUrl': "assets/images/logos/TMDb.png",
    'color': 0xff191A32,
    'padding': 0.0
  },
  {
    'title': "Rotten Tomatoes",
    'imgUrl': "assets/images/logos/RottenTomatoes.png",
    'color': 0xffFE0000,
    'padding': 0.0
  },
  {
    'title': "Metacritic",
    'imgUrl': "assets/images/logos/Metacritic.png",
    'color': 0xffF4F4F4,
    'padding': 7.5
  },
  {
    'title': "Netflix",
    'imgUrl': "assets/images/logos/Netflix.png",
    'color': 0xff000000,
    'padding': 2.5
  },
  {
    'title': "Film Affinity",
    'imgUrl': "assets/images/logos/FilmAffinity.png",
    'color': 0xffF4F4F4,
    'padding': 0.0
  },
  {
    'title': "Google Play",
    'imgUrl': "assets/images/logos/GooglePlay.png",
    'color': 0xffF4F4F4,
    'padding': 10.0
  },
  {
    'title': "Web Search",
    'imgUrl': "assets/images/logos/Google.png",
    'color': 0xffF4F4F4,
    'padding': 10.0
  },
  {
    'title': "YouTube",
    'imgUrl': "assets/images/logos/YouTube.png",
    'color': 0xffF4F4F4,
    'padding': 10.0
  },
  {
    'title': "Wikipedia",
    'imgUrl': "assets/images/logos/Wikipedia.png",
    'color': 0xffF4F4F4,
    'padding': 7.5
  },
];
