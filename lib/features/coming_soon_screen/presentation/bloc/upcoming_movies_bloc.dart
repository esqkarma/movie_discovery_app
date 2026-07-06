import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_cinema_app/features/coming_soon_screen/data/repository/upcoming_repository.dart';
import 'package:task_cinema_app/features/coming_soon_screen/presentation/bloc/upcoming_movies_event.dart';
import 'package:task_cinema_app/features/coming_soon_screen/presentation/bloc/upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final UpcomingRepository upcomingRepository;
  UpcomingMoviesBloc(this.upcomingRepository) : super(UpcomingMoviesInitial()) {
    on<FetchUpcomingMovies>(fetchUpcomingMovies);
  }
  Future<void> fetchUpcomingMovies(
    FetchUpcomingMovies event,
    Emitter<UpcomingMoviesState> emit,
  ) async {
    try {
      emit(UpcomingMoviesLoading());
      final result = await upcomingRepository.getUpComingMovies();
      emit(UpcomingMoviesLoaded(upcomingMovies: result));
    } catch (e) {
      emit(UpcomingMoviesError(message: e.toString()));
    }
  }
}
