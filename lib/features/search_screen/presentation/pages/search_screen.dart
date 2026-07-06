import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cinema_app/features/widgets/shimmer_widget.dart';

import '../../../widgets/error_page.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  context.read<SearchBloc>().add(SearchMovies(value));
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();

                      context.read<SearchBloc>().add(LoadTopSearches());
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),

                  filled: true,
                  fillColor: Colors.grey.shade900,
                  hintText: "Search movies...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitialLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Top Searches",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.topSearches.length,
                            itemBuilder: (context, index) {
                              final movie = state.topSearches[index];

                              return Container(
                                height: 80,
                                margin: const EdgeInsets.only(bottom: 4),
                                color: const Color(0xff424242),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 140,
                                      height: 80,
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Text(
                                        movie.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),

                                    const Padding(
                                      padding: EdgeInsets.only(right: 12),
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is SearchLoading) {
                    return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (_, __) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              ShimmerBox(
                                height: 70,
                                width: 120,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: ShimmerBox(
                                  height: 20,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (state is SearchError) {
                    return ErrorView(
                      title: "Search Failed",
                      subtitle: "We couldn't fetch search results right now.",
                      onRetry: () {
                        context.read<SearchBloc>().add(LoadTopSearches());
                      },
                    );
                  }

                  if (state is SearchLoaded) {
                    if (state.movies.isEmpty) {
                      return const Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.65,
                          ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }

                  return ShimmerBox(height: 50, width: double.infinity);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
