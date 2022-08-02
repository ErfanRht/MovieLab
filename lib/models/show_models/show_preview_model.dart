import 'dart:convert';

import 'package:flutter/material.dart';

// Movie or TV show preview model class
class ShowPreview {
  final String id;
  final String rank;
  final String title;
  final String crew;
  final String image;
  final String year;
  final String imDbRating;
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

  const ShowPreview({
    required this.id,
    required this.rank,
    required this.title,
    required this.crew,
    required this.image,
    required this.year,
    required this.imDbRating,
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
  });

  factory ShowPreview.fromJson(Map<String, dynamic> json) {
    return ShowPreview(
      id: json['id'],
      rank: json['rank'] ?? "",
      title: json['title'],
      crew: json['crew'] ?? "",
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'] ?? "",
      imDbRating:
          json['imDbRating'] == "" ? "0.0" : json['imDbRating'] ?? "0.0",
      weekend: json['weekend'] ?? "",
      gross: json['gross'] ?? "",
      weeks: json['weeks'] ?? "",
      worldwideLifetimeGross: json['worldwideLifetimeGross'] ?? "",
      domesticLifetimeGross: json['domesticLifetimeGross'] ?? "",
      domestic: json['domestic'] ?? "",
      foreignLifetimeGross: json['foreignLifetimeGross'] ?? "",
      foreign: json['foreign'] ?? "",
    );
  }

  static Map<String, dynamic> toMap(ShowPreview show) => {
        'id': show.id,
        'rank': show.rank,
        'title': show.title,
        'crew': show.crew,
        'image': show.image,
        'year': show.year,
        'imDbRating': show.imDbRating,
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
