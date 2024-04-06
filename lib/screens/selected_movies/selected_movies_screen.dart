import 'package:flutter/material.dart';

class SelectedMoviesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedMovies;

  SelectedMoviesScreen({required this.selectedMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Seleccionadas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedMovies.length,
              itemBuilder: (context, index) {
                final movie = selectedMovies[index];
                return CustomMovieTile(
                    movie:
                        movie); // Usar un ListTile personalizado para mostrar la película
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para realizar la compra
              print('Compra realizada');
            },
                        style: ElevatedButton.styleFrom(
              // Establecer el estilo del botón
              backgroundColor: Colors.green, // Cambiar el color de fondo del botón a verde
            ),
            child: Text('Comprar'),
          ),
        ],
      ),
    );
  }
}


class CustomMovieTile extends StatefulWidget {
  final Map<String, dynamic> movie;

  const CustomMovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  _CustomMovieTileState createState() => _CustomMovieTileState();
}

class _CustomMovieTileState extends State<CustomMovieTile> {
  int _quantity = 0;
  final double _moviePrice = 20.0; // Precio de la película

  @override
  Widget build(BuildContext context) {
    double totalPrice = _quantity * _moviePrice; // Calcular el precio total

    return ListTile(
      leading: SizedBox(
        width: 100, // Aumentar el ancho de la imagen
        height: 150, // Ajustar la altura de la imagen
        child: Image.network(
          'https://image.tmdb.org/t/p/w200${widget.movie['poster_path']}',
          fit: BoxFit.cover,
        ),
      ),
      title: Text(widget.movie['title']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.movie['overview'] ?? ''),
          SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_quantity > 0) {
                      _quantity--; // Reducir la cantidad
                    }
                  });
                },
                icon: Icon(Icons.remove),
              ),
              Text('$_quantity'), // Mostrar la cantidad actual
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++; // Aumentar la cantidad
                  });
                },
                icon: Icon(Icons.add),
              ),
              Text(
                'Precio total: \$${totalPrice.toStringAsFixed(2)}', // Mostrar el precio total
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
