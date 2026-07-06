import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<FetchHomeMovies>(_fetchMovies);
  }

  Future<void> _fetchMovies(
    FetchHomeMovies event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());

      final results = await Future.wait([
        repository.getTrendingMovies(),
        repository.getPopularMovies(),
        repository.getNowPlayingMovies(),
        repository.getTopRatedMovies(),
        repository.getTopInRegion(),
      ]);

      emit(
        HomeLoaded(
          trending: results[0],
          popular: results[1],
          nowPlaying: results[2],
          topRated: results[3],
          topInRegion: results[4],
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
