import 'package:dio/dio.dart';
import '../../../../core/conf/env.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../model/movie_model.dart';

class HomeRemoteDatasource {
  final Dio dio;

  HomeRemoteDatasource(this.dio);

  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await dio.get(ApiConstants.trendingMovies);

    final List results = response.data['results'];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dio.get(ApiConstants.popularMovies);

    final List results = response.data['results'];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await dio.get(ApiConstants.nowPlayingMovies);

    final List results = response.data['results'];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await dio.get(ApiConstants.topRatedMovies);

    final List results = response.data['results'];

    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }

  Future<List<MovieModel>> getTopInRegion() async {
    final response = await dio.get(
      ApiConstants.topInRegion,
      queryParameters: {'region': "NG", 'sort_by': 'popularity.desc'},
    );
    final results = response.data['results'] as List;
    return results.map((e) => MovieModel.fromJson(e)).toList();
  }
}
