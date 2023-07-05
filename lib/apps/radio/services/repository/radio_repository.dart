import 'dart:convert';

import 'package:radio/apps/radio/model/station.dart';
import 'package:radio/helpers/cache_helper.dart';
import 'package:radio/helpers/http_cached_helper.dart';

import '../../../../config.dart';

class RadioRepository {
  final httpBase =
      HttpCached(CacheHelper(CacheOptions(const Duration(minutes: 5))));

  Future<Station> fetchStation() async {
    final response =
        await httpBase.get(Uri.parse('${Config.radioBaseUrl}/radio/station/'));

    if (response.statusCode == 200) {
      return Station.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }
}
