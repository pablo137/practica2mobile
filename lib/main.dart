import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2mobile/cubits/popular_movies_cubit.dart';
import 'package:practica2mobile/screens/movies/movies_screen.dart'; // Importa tu pantalla de películas populares

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas Populares',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => PopularMoviesCubit()..fetchPopularMovies(),
        child: PopularMoviesScreen(),
      ),
    );
  }
}
