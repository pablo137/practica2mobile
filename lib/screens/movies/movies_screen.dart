import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2mobile/cubits/popular_movies_cubit.dart';
import 'package:practica2mobile/screens/movies/custom_app_bar.dart';
import 'package:practica2mobile/widgets/movie_card.dart'; // Importa tu Cubit de películas populares

class PopularMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PopularMoviesLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(
                  movie: movie,
                  // onAddToCart: () {
                  //   // Aquí puedes manejar la lógica para añadir la película al carrito
                  //   print('Añadir "${movie['title']}" al carrito');
                  // },
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