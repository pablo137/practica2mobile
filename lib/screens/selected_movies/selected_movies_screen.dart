import 'package:flutter/material.dart';
import 'package:practica2mobile/screens/success/success_screen.dart';
import 'package:practica2mobile/widgets/movie_card.dart';

class SelectedMoviesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedMovies;

  SelectedMoviesScreen({required this.selectedMovies});

  @override
  _SelectedMoviesScreenState createState() => _SelectedMoviesScreenState();
}

class _SelectedMoviesScreenState extends State<SelectedMoviesScreen> {
  double totalCost = 0.0;

  @override
  void initState() {
    super.initState();
    // Calcular el costo total inicial
    updateTotalCost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Seleccionadas'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Costo Total de todas las películas: \$${totalCost.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedMovies.length,
              itemBuilder: (context, index) {
                final movie = widget.selectedMovies[index];
                return MovieCard(
                  movie: movie,
                  selectedMovies: widget.selectedMovies,
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navegar a la pantalla "Success" al hacer clic en el botón "Comprar"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuccessScreen()),
              );
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

  // Método para actualizar el costo total
  void updateTotalCost() {
    double cost = 0.0;
    List<String> selectedMovieTitles = [];

    for (var movie in widget.selectedMovies) {
      // Asegurarse de que solo se cuente una vez el costo de cada película
      if (!selectedMovieTitles.contains(movie['title'])) {
        cost += 20.0; // Precio fijo de cada película (suponiendo $20)
        selectedMovieTitles.add(movie['title']);
      }
    }

    setState(() {
      totalCost = cost;
    });
  }
}
