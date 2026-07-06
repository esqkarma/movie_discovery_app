import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/respository/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  Timer? _debounce;

  SearchBloc(this.repository) : super(SearchInitial()) {
    on<SearchMovies>(_onSearchMovies);
    on<LoadTopSearches>(_loadTopSearches);
  }

  Future<void> _loadTopSearches(
    LoadTopSearches event,
    Emitter<SearchState> emit,
  ) async {
    final movies = await repository.getTopSearches();

    emit(SearchInitialLoaded(topSearches: movies));
  }

  Future<void> _onSearchMovies(
    SearchMovies event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final movies = await repository.searchMovies(event.query);

      emit(SearchLoaded(movies: movies));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
