import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/cubits/movieDetailsCubit/movie_detail_cubit.dart';
import 'package:movie_app/domain/cubits/movieTrailersCubit/movie_trailers_cubit.dart';
import 'package:movie_app/domain/cubits/nowPlayingListCubit/now_playing_movies_cubit.dart';
import 'package:movie_app/domain/cubits/popularMoviesCubit/popular_movies_cubit.dart';
import 'package:movie_app/domain/cubits/upcomingMoviesCubit/upcoming_movies_cubit.dart';
import 'package:movie_app/screen/main_page.dart';
import 'package:movie_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesCubit>(
            create: (_) => NowPlayingMoviesCubit()),
        BlocProvider<UpcomingMoviesCubit>(create: (_) => UpcomingMoviesCubit()),
        BlocProvider<PopularMoviesCubit>(create: (_) => PopularMoviesCubit()),
        BlocProvider<MovieDetailCubit>(create: (_) => MovieDetailCubit()),
        BlocProvider<MovieTrailersCubit>(create: (_) => MovieTrailersCubit()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: const MainPage(),
          onGenerateRoute: (setting) => Routes.generateRoute(setting)),
    );
  }
}
