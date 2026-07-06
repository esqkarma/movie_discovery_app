import 'package:task_cinema_app/model/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchInitialLoaded extends SearchState {
  final List<MovieModel> topSearches;

  SearchInitialLoaded({required this.topSearches});
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MovieModel> movies;

  SearchLoaded({required this.movies});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}
