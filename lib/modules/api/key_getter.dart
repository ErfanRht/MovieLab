import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/.api.dart';

Future<bool> key_getter() async {
  const String url = "";
  if (url != "") {
    var response = await http.get(Uri.parse(url)).timeout(
          const Duration(seconds: 10),
        );
    if (kDebugMode) {
      print(jsonDecode(response.body).length);
    }
    apiKeys = [for (dynamic key in jsonDecode(response.body)) key.toString()];
  }
  return true;
}
