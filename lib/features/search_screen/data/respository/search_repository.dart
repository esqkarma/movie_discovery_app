import '../../../../model/movie_model.dart';
import '../datasource/search_remote_datasource.dart';

class SearchRepository {
  final SearchRemoteDatasource remoteDatasource;

  SearchRepository(this.remoteDatasource);

  Future<List<MovieModel>> searchMovies(String query) {
    return remoteDatasource.searchMovies(query);
  }

  Future<List<MovieModel>> getTopSearches() {
    return remoteDatasource.getTopSearches();
  }
}
