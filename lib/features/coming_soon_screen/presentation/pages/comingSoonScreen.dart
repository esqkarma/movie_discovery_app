import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cinema_app/features/widgets/shimmer_widget.dart';
import 'package:task_cinema_app/model/movie_model.dart';

import '../../../../core/constants/gener_map.dart';
import '../../../widgets/error_page.dart';
import '../bloc/upcoming_movies_bloc.dart';
import '../bloc/upcoming_movies_event.dart';
import '../bloc/upcoming_movies_state.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
      builder: (context, state) {
        print("STATE: ${state.runtimeType}");
        if (state is UpcomingMoviesLoading) {
          return ComingSoonShimmer();
        }
        if (state is UpcomingMoviesLoaded) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.upcomingMovies.length,
                      itemBuilder: (context, index) {
                        return _ComingSoonCard(
                          movie: state.upcomingMovies[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is UpcomingMoviesError) {
          return ErrorView(
            title: "Couldn't Load Upcoming Movies",
            subtitle: "Please check your internet connection and try again.",
            onRetry: () {
              context.read<UpcomingMoviesBloc>().add(FetchUpcomingMovies());
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ComingSoonCard extends StatelessWidget {
  final MovieModel movie;

  const _ComingSoonCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
          scale: 0.5,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _iconButton(Icons.notifications_none, "Remind Me"),
              const SizedBox(width: 20),
              _iconButton(Icons.share_outlined, "Share"),
            ],
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Text(
        //     movie.!,
        //     style: const TextStyle(color: Colors.white70, fontSize: 12),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            movie.overview,
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            movie.genreIds.map((id) => genreMap[id] ?? '').join(' • '),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _iconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}
