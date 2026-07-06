import '../../../../model/movie_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> trending;
  final List<MovieModel> popular;
  final List<MovieModel> nowPlaying;
  final List<MovieModel> topRated;
  final List<MovieModel> topInRegion;

  HomeLoaded({
    required this.trending,
    required this.popular,
    required this.nowPlaying,
    required this.topRated,
    required this.topInRegion,
  });
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
