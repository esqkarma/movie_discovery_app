import 'package:dio/dio.dart';
import 'package:task_cinema_app/core/constants/api_constants.dart';
import 'package:task_cinema_app/model/movie_model.dart';

class UpcomingRemoteDatasource {
  final Dio dio;

  UpcomingRemoteDatasource(this.dio);

  Future<List<MovieModel>> getUpcomingMovies() async {
    print("called");
    final response = await dio.get(ApiConstants.upcomingMovies);
    final List results = response.data['results'];
    print("jjjjj");
    print(results);
    return results.map((movie) => MovieModel.fromJson(movie)).toList();
  }
}
