import '../../../../model/movie_model.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepository(this.remoteDatasource);

  Future<List<MovieModel>> getTrendingMovies() {
    return remoteDatasource.getTrendingMovies();
  }

  Future<List<MovieModel>> getNowPlayingMovies() {
    return remoteDatasource.getNowPlayingMovies();
  }

  Future<List<MovieModel>> getTopRatedMovies() {
    return remoteDatasource.getTopRatedMovies();
  }

  Future<List<MovieModel>> getPopularMovies() {
    return remoteDatasource.getPopularMovies();
  }

  Future<List<MovieModel>> getTopInRegion() {
    return remoteDatasource.getTopInRegion();
  }
}
