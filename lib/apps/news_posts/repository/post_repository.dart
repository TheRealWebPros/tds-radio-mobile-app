import 'dart:convert';

import 'package:radio/apps/news_posts/model/post_model.dart';
import 'package:radio/helpers/cache_helper.dart';
import 'package:radio/config.dart';
import 'package:radio/helpers/http_cached_helper.dart';

class PostRepository {
  final httpBase =
      HttpCached(CacheHelper(CacheOptions(const Duration(minutes: 5))));

  Future<List<Post>> fetchPosts() async {
    final response = await httpBase.get(
        Uri.parse("${Config.radioBaseUrl}/wp/v2/posts?_embed&per_page=100"));

    if (response.statusCode != 200) {
      throw Exception(" ${response.statusCode} - ${response.reasonPhrase}");
    }

    // else {
    //      final List<dynamic> jsonData = jsonDecode(response.body);
    //   return jsonData.map((item) => Post.fromJson(item)).toList();
    // }

    return convertMapList(jsonDecode(response.body))
        .map<Post>((item) => Post.fromJson(item))
        .toList();
  }

  List<Map<String, dynamic>> convertMapList(List<dynamic> obj) {
    return obj.map((e) => e as Map<String, dynamic>).toList();
  }
}
