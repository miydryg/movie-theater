import 'package:cinema_bloc_ui/login/welcome_page.dart';
import 'package:cinema_bloc_ui/repository/auth_repository.dart';
import 'package:cinema_bloc_ui/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/bloc/movie_bloc.dart';

import 'bloc/cinema/cinema_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiBlocProvider(
        providers: [
          BlocProvider<CinemaBloc>(
            create: (context) => CinemaBloc(),
          ),
          BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(MovieRepository()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              AuthRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie app',
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: RepositoryProvider(
            create: (context) => AuthRepository(),
            child: WelcomePage(),
          ),
        ));
  }
}
