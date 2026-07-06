import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_cinema_app/features/coming_soon_screen/data/datasource/upcoming_remote_datasource.dart';
import 'package:task_cinema_app/features/coming_soon_screen/data/repository/upcoming_repository.dart';
import 'package:task_cinema_app/features/coming_soon_screen/presentation/bloc/upcoming_movies_bloc.dart';
import 'package:task_cinema_app/features/search_screen/presentation/bloc/search_event.dart';

import 'core/network/dio_client.dart';
import 'features/coming_soon_screen/presentation/bloc/upcoming_movies_event.dart';
import 'features/home/data/datasource/home_remote_datasource.dart';
import 'features/home/data/repository/home_repository.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/home_event.dart';
import 'features/search_screen/data/datasource/search_remote_datasource.dart';
import 'features/search_screen/data/respository/search_repository.dart';
import 'features/search_screen/presentation/bloc/search_bloc.dart';
import 'features/splash_screen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) =>
              HomeBloc(HomeRepository(HomeRemoteDatasource(DioClient.dio)))
                ..add(FetchHomeMovies()),
        ),

        BlocProvider(
          create: (_) => UpcomingMoviesBloc(
            UpcomingRepository(UpcomingRemoteDatasource(DioClient.dio)),
          )..add(FetchUpcomingMovies()),
        ),

        BlocProvider(
          create: (_) => SearchBloc(
            SearchRepository(SearchRemoteDatasource(DioClient.dio)),
          )..add(LoadTopSearches()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
