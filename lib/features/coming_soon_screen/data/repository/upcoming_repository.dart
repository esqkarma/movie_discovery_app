import 'package:task_cinema_app/features/coming_soon_screen/data/datasource/upcoming_remote_datasource.dart';
import 'package:task_cinema_app/model/movie_model.dart';

class UpcomingRepository {
  final UpcomingRemoteDatasource remoteDatasource;
  UpcomingRepository(this.remoteDatasource);

  Future<List<MovieModel>> getUpComingMovies() async {
    return remoteDatasource.getUpcomingMovies();
  }
}
