import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cinema_app/features/widgets/shimmer_widget.dart';

import '../../../../model/movie_model.dart';
import '../../../widgets/error_page.dart';
import '../../data/datasource/home_remote_datasource.dart';
import '../../data/repository/home_repository.dart';
import 'package:task_cinema_app/core/network/dio_client.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const HomeShimmer();
            }

            if (state is HomeLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(FetchHomeMovies());

                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _HeroBanner(movie: state.topInRegion.first),
                    ),

                    SliverToBoxAdapter(
                      child: _MovieSection(
                        title: "Preview",
                        movies: state.topRated,
                        isCircular: true,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: _MovieSection(
                        title: "Continue Watching",
                        movies: state.nowPlaying,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: _MovieSection(
                        title: "Trending Now",
                        movies: state.trending,
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: _MovieSection(
                        title: "Popular",
                        movies: state.popular,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeError) {
              return ErrorView(
                title: "Couldn't Load Movies",
                subtitle:
                    "Please check your internet connection and try again.",
                onRetry: () {
                  context.read<HomeBloc>().add(FetchHomeMovies());
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final MovieModel movie;

  const _HeroBanner({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .65,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://image.tmdb.org/t/p/original${movie.backdropPath}",
            fit: BoxFit.cover,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(.3),
                  Colors.black,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset("assets/symbol.png", width: 30),
                      const Text(
                        "TV Shows",
                        style: TextStyle(color: Colors.white),
                      ),

                      const Text(
                        "Movies",
                        style: TextStyle(color: Colors.white),
                      ),

                      const Text(
                        "My List",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                const Text(
                  "#1 in Nigeria Today",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionButton(icon: Icons.add, title: "My List"),

                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow, color: Colors.black),
                        label: const Text(
                          "Play",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),

                      _ActionButton(icon: Icons.info_outline, title: "Info"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ActionButton({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _MovieSection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final bool isCircular;

  const _MovieSection({
    required this.title,
    required this.movies,
    this.isCircular = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: isCircular ? 110 : 180,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (_, index) {
              if (isCircular) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${movies[index].posterPath}",
                    ),
                  ),
                );
              }

              return Container(
                width: 110,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${movies[index].posterPath}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
