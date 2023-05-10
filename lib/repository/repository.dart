import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/model/movie_model.dart';



class MovieRepository {
  String endpoint = 'https://fs-mt.qwerty123.tech/api/movies?date=2023-04-24';
  final String accessToken =
      "Bearer 251|CzXRiEmabg0Yt9tuWCgLeLrpiQrUIuExMwVTW9Bu";
  Future<List<MovieModelApi>> getMovies() async {
    http.Response response = await http
        .get(Uri.parse(endpoint), headers: {'Authorization': '$accessToken'});
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => MovieModelApi.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
