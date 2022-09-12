String imageQualityIncreaser(final String url) {
  try {
    final suffix = RegExp(r'(._.*).jpg').firstMatch(url);
    return url.replaceAll(suffix!.group(1).toString(), '');
  } catch (e) {
    return url;
  }
}
