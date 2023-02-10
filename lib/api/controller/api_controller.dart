import 'dart:convert';

import 'package:exps_app/api/model/News.dart';
import 'package:http/http.dart' as http;

class NewsProviders{
  Uri uri = Uri.parse("https://newsapi.org/v2/top-headlines?country=kr&apiKey=60060db96b3d4d38ad8d089047dc6044");

  Future<List<News>> getNews() async {
    List<News> news = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      news = jsonDecode(response.body)['articles'].map<News>( (article) {
        return News.fromMap(article);
      }).toList();
    }

    return news;
  }


}