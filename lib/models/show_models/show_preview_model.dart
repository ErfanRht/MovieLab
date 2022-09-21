import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movielab/modules/tools/image_quality_increaser.dart';

// Movie or TV show preview model class
class ShowPreview {
  final String id;
  final String rank;
  final String title;
  final String type;
  final String crew;
  final String image;
  final String year;
  final String? released;
  final String imDbRating;
  final String? imDbVotes;
  final String? seasonNumber;
  final String? episodeNumber;
  final String? plot;
  final String weekend;
  final String gross;
  final String weeks;
  final String worldwideLifetimeGross;
  final String domesticLifetimeGross;
  final String domestic;
  final String foreignLifetimeGross;
  final String foreign;
  final String? genres;
  final String? countries;
  final String? languages;
  final String? companies;
  final String? contentRating;
  final DateTime? watchDate;
  final TimeOfDay? watchTime;
  final List<ShowPreview>? similars;

  const ShowPreview({
    required this.id,
    required this.rank,
    required this.title,
    required this.type,
    required this.crew,
    required this.image,
    required this.year,
    this.released,
    required this.imDbRating,
    this.imDbVotes,
    this.seasonNumber,
    this.episodeNumber,
    this.plot,
    required this.weekend,
    required this.gross,
    required this.weeks,
    required this.worldwideLifetimeGross,
    required this.domesticLifetimeGross,
    required this.domestic,
    required this.foreignLifetimeGross,
    required this.foreign,
    this.genres,
    this.countries,
    this.languages,
    this.companies,
    this.contentRating,
    this.watchDate,
    this.watchTime,
    this.similars,
  });

  factory ShowPreview.fromJson(Map<String, dynamic> json) {
    return ShowPreview(
      id: json['id'] ?? "",
      rank: json['rank'] ?? "",
      title: json['title'] ?? "",
      type: json['type'] ?? json['role'] ?? "",
      crew: json['crew'] ?? json['stars'] ?? json['role'] ?? "",
      image: imageQualityIncreaser(json['image']),
      year: json['year'] ??
          (json['description'] != null
              ? json['description']
                  .toString()
                  .replaceAll("(", "")
                  .replaceAll(")", "\n")
              : ""),
      released: json['released'] ?? "",

      // Imdb rating should'nt be null, but sometimes it is.
      imDbRating:
          json['imDbRating'] == "" ? "0.0" : json['imDbRating'] ?? "0.0",
      imDbVotes: json['imDbRatingCount'] ?? "0.0",
      seasonNumber: json['seasonNumber'] ?? "",
      episodeNumber: json['episodeNumber'] ?? "",
      plot: json['plot'] ?? "",
      weekend: json['weekend'] ?? "",
      gross: json['gross'] ?? "",
      weeks: json['weeks'] ?? "",
      worldwideLifetimeGross: json['worldwideLifetimeGross'] ?? "",
      domesticLifetimeGross: json['domesticLifetimeGross'] ?? "",
      domestic: json['domestic'] ?? "",
      foreignLifetimeGross: json['foreignLifetimeGross'] ?? "",
      foreign: json['foreign'] ?? "",
      companies: json['companies'] ?? "",
      contentRating: json['contentRating'] ?? "",
      countries: json['countries'] ?? "",
      genres: json['genres'] ?? "",
      languages: json['languages'] ?? "",
      similars: json['similars'] == null
          ? null
          : [
              for (var similar in json['similars']!)
                ShowPreview.fromJson(similar)
            ],
      watchDate:
          json["watchDate"] == null ? null : DateTime.parse(json["watchDate"]),
      watchTime: json['watchTime'] == null
          ? null
          : TimeOfDay.fromDateTime(DateTime.parse(json["watchDate"])),
    );
  }

  static Map<String, dynamic> toMap(ShowPreview show) => {
        'id': show.id,
        'rank': show.rank,
        'title': show.title,
        'type': show.type,
        'crew': show.crew,
        'image': show.image,
        'year': show.year,
        'imDbRating': show.imDbRating,
        'imDbVotes': show.imDbVotes,
        'released': show.released,
        'seasonNumber': show.seasonNumber,
        'episodeNumber': show.episodeNumber,
        'plot': show.plot,
        'genres': show.genres,
        'countries': show.countries,
        'languages': show.languages,
        'companies': show.companies,
        'contentRating': show.contentRating,
        'watchDate': show.watchDate?.toString(),
        'watchTime': show.watchTime?.toString(),
        'similars': [
          for (var similar in show.similars!) ShowPreview.toMap(similar)
        ]
      };

  static String encode(List<ShowPreview> shows) => json.encode(
        shows
            .map<Map<String, dynamic>>((music) => ShowPreview.toMap(music))
            .toList(),
      );

  static List<ShowPreview> decode(String shows) =>
      (json.decode(shows) as List<dynamic>)
          .map<ShowPreview>((item) => ShowPreview.fromJson(item))
          .toList();
}
