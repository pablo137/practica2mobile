import 'package:flutter/material.dart';
import 'package:practica2mobile/screens/success/success_screen.dart';

class SelectedMoviesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedMovies;

  SelectedMoviesScreen({required this.selectedMovies});

  @override
  _SelectedMoviesScreenState createState() => _SelectedMoviesScreenState();
}

class _SelectedMoviesScreenState extends State<SelectedMoviesScreen> {
  Map<int, int> _selectedQuantities =
      {}; // Mapa para almacenar la cantidad seleccionada para cada película
  final double _moviePrice = 20.0; // Precio de cada película
  double _totalPrice = 0.0; // Precio total de todas las películas seleccionadas

  @override
  void initState() {
    super.initState();
    _updateTotalPrice(); // Inicializar el precio total al inicio
  }

  void _updateTotalPrice() {
    double totalPrice = 0.0;
    _selectedQuantities.forEach((movieId, quantity) {
      totalPrice += quantity * _moviePrice;
    });
    setState(() {
      _totalPrice = totalPrice;
    });
  }

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
              itemCount: widget.selectedMovies.length,
              itemBuilder: (context, index) {
                final movie = widget.selectedMovies[index];
                final movieId = movie['id']
                    as int; // Se asume que 'id' es el identificador único de la película
                final quantity = _selectedQuantities[movieId] ??
                    0; // Obtener la cantidad seleccionada para esta película
                final totalPrice = quantity *
                    _moviePrice; // Calcular el precio total para esta película

                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    height: 150,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(movie['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie['overview'] ?? ''),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) {
                                  _selectedQuantities[movieId] =
                                      quantity - 1; // Decrementar la cantidad
                                  _updateTotalPrice(); // Actualizar el precio total
                                }
                              });
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text('$quantity'),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedQuantities[movieId] =
                                    quantity + 1; // Incrementar la cantidad
                                _updateTotalPrice(); // Actualizar el precio total
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                          Text(
                            'Precio total: \$${totalPrice.toStringAsFixed(2)}',
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
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessScreen(totalPrice: _totalPrice),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text('Comprar'),
          ),
        ],
      ),
    );
  }
}
