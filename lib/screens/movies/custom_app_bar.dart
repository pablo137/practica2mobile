import 'package:flutter/material.dart';
import 'package:practica2mobile/screens/selected_movies/selected_movies_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Map<String, dynamic>> selectedMovies; // Nueva propiedad para la lista de películas seleccionadas

  CustomAppBar({required this.selectedMovies}); // Constructor actualizado para recibir la lista

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Películas Populares'),
      actions: [
        CartIconButton(selectedMovies: selectedMovies), // Pasar la lista de películas seleccionadas al CartIconButton
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CartIconButton extends StatelessWidget {
  final List<Map<String, dynamic>> selectedMovies; // Lista de películas seleccionadas

  CartIconButton({required this.selectedMovies}); // Constructor para recibir la lista

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.movie_filter_outlined),
          onPressed: () {
            // Navegar a la pantalla de películas seleccionadas
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedMoviesScreen(selectedMovies: selectedMovies),
              ),
            );
          },
        ),
        // Resto del contenido
      ],
    );
  }
}
