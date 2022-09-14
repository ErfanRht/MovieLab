import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/.api.dart';
import 'package:movielab/constants/app.dart';
import 'package:movielab/constants/types.dart';

Future<RequestResult> key_getter() async {
  const String url = "";
  if (url != "") {
    var response = await http.get(Uri.parse(url)).timeout(
          const Duration(seconds: 10),
        );
    if (kDebugMode) {
      print(
          "${jsonDecode(response.body)['keys'].length} api keys has been added.");
    }
    apiKeys = [
      for (dynamic key in jsonDecode(response.body)['keys']) key.toString()
    ];
    supportedVersions = [
      for (dynamic version in jsonDecode(response.body)['supported_versions'])
        version.toString()
    ];
    latestVersion = jsonDecode(response.body)['latest_version'].toString();
    secureUrl = jsonDecode(response.body)['secure_url'].toString();
    return RequestResult.SUCCESS;
  }
  return RequestResult.FAILURE;
}
