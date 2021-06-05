import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task1/Models/newsinfo.dart';
import 'package:task1/constants/Strings.dart';

class ApiManager {
  Future<Welcome> getnews() async {
    var newsmodel;
    try {
      var response = await http.get(Uri.parse(Strings.newsurl));
      if (response.statusCode == 200) {
        var jsonresponse = response.body;
        var jsonMap = json.decode(jsonresponse);
        newsmodel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsmodel;
    }

    return newsmodel;
  }
}
