import 'package:task_cinema_app/model/movie_model.dart';

class UpcomingMoviesState {}

class UpcomingMoviesInitial extends UpcomingMoviesState {}

class UpcomingMoviesLoading extends UpcomingMoviesState {}

class UpcomingMoviesLoaded extends UpcomingMoviesState {
  final List<MovieModel> upcomingMovies;
  UpcomingMoviesLoaded({required this.upcomingMovies});
}

class UpcomingMoviesError extends UpcomingMoviesState {
  final String message;
  UpcomingMoviesError({required this.message});
}
