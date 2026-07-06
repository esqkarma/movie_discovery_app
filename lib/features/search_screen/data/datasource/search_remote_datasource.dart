import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../model/movie_model.dart';

class SearchRemoteDatasource {
  final Dio dio;

  SearchRemoteDatasource(this.dio);

  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await dio.get(
      ApiConstants.searchMovies,
      queryParameters: {"query": query},
    );

    final List results = response.data["results"];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  Future<List<MovieModel>> getTopSearches() async {
    final response = await dio.get(ApiConstants.popularMovies);

    final List results = response.data["results"];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
