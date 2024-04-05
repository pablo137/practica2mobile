import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2mobile/cubits/popular_movies_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Películas Populares'),
      actions: [
        CartIconButton(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CartIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
      builder: (context, state) {
        // Calcula la cantidad total de películas en el carrito
        int cartItemCount = 0;
        // Aquí debes obtener la cantidad total de películas en el carrito del estado

        return Stack(
          children: [
            IconButton(
              icon: Icon(Icons.movie_filter_outlined),
              onPressed: () {
                // Aquí puedes manejar la acción al presionar el icono del carrito
                print('Abrir carrito');
              },
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    cartItemCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
