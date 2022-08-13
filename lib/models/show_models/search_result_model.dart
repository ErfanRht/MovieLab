// Movie or TV show as result of a search model class
class SearchResult {
  final String id;
  final String title;
  final String image;
  final String description;
  final String resultType;

  const SearchResult({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.resultType,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      title: json['title'],
      image: json['image'].replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      description:
          json['description'].replaceAll("(", "").replaceAll(")", "") ?? "",
      resultType: json['resultType'] ?? "",
    );
  }
}
