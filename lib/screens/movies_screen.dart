import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2mobile/cubit/popular_movies_cubit.dart'; // Importa tu Cubit de películas populares

class PopularMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Populares'),
      ),
      body: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PopularMoviesLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['title']),
                  subtitle: Text(movie['overview']),
                  // Puedes agregar más información del movie si lo deseas
                );
              },
            );
          } else if (state is PopularMoviesError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
