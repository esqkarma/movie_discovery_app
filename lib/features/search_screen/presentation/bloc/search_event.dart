abstract class SearchEvent {}

class SearchMovies extends SearchEvent {
  final String query;

  SearchMovies(this.query);
}

class LoadTopSearches extends SearchEvent {}
