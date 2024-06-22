import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mireno_movie/provider/discover/discover_provider.dart';

const baseUrl = 'https://api.themoviedb.org/3/movie/';
const baseImageUrl = 'https://image.tmdb.org/t/p/';
const apiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWM2OTIwYTY1M2U2NTRhZGNjNjhmYmJkNmYzZWYyNCIsInN1YiI6IjY2NTEwZDljZmY0OWFkZTZhYzk1ZDdmOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.i_pfpJLphqBz8NNsS2MNI6bj1-OFndAou3qpAyBs_gM';

class ApiService {
  static const nowPlayingUrl = "${baseUrl}now_playing";
  static const popularUrl = "${baseUrl}popular";
  static const topRateUrl = "${baseUrl}top_rated";
  static const upComingUrl = "${baseUrl}upcoming";
  Future<PeliculaProvider> fetchNowPlayingMovies() async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse(nowPlayingUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PeliculaProvider.fromJson(data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
      // llamado a la api para obtner las mas populares
    Future<PeliculaProvider> fetchPopularMovies() async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse(popularUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PeliculaProvider.fromJson(data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
      Future<PeliculaProvider> fetchTopRateMovies() async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse(topRateUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PeliculaProvider.fromJson(data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
    Future<PeliculaProvider> fetchUpComingMovies() async {
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse(upComingUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PeliculaProvider.fromJson(data);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
