import 'package:flutter/material.dart';

class SelectedMovieCard extends StatefulWidget {
  final Map<String, dynamic> movie;
  final Function(bool) onSelected; // Callback para manejar la selección de la película

  const SelectedMovieCard({
    Key? key,
    required this.movie,
    required this.onSelected,
  }) : super(key: key);

  @override
  _SelectedMovieCardState createState() => _SelectedMovieCardState();
}

class _SelectedMovieCardState extends State<SelectedMovieCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected); // Llamar al callback con el estado de la selección
        });
      },
      child: Card(
        child: Row(
          children: [
            // Imagen a la izquierda
            Flexible(
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${widget.movie['poster_path']}',
                fit: BoxFit.cover,
                width: 100, // Ancho fijo para la imagen
                height: double.infinity,
              ),
            ),
            SizedBox(width: 16), // Espacio entre la imagen y el texto
            // Texto del título
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8), // Espacio entre el título y el resumen
                  Text(
                    widget.movie['overview'],
                    maxLines: 3, // Mostrar solo tres líneas del resumen
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
