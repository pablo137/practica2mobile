import 'package:flutter/material.dart';
import 'package:practica2mobile/screens/success/success_screen.dart';

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
            'Costo Total de todas las películas diferentes: \$${totalCost.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedMovies.length,
              itemBuilder: (context, index) {
                final movie = widget.selectedMovies[index];
                return CustomMovieTile(
                  movie: movie,
                  onQuantityChanged: (quantity) {
                    // Actualizar el costo total cada vez que cambia la cantidad
                    updateTotalCost();
                  },
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
        cost += movie['price'] as double; // Sumar el precio de cada película seleccionada
        selectedMovieTitles.add(movie['title']);
      }
    }

    setState(() {
      totalCost = cost;
    });
  }
}

class CustomMovieTile extends StatefulWidget {
  final Map<String, dynamic> movie;
  final Function(int) onQuantityChanged;

  const CustomMovieTile({Key? key, required this.movie, required this.onQuantityChanged}) : super(key: key);

  @override
  _CustomMovieTileState createState() => _CustomMovieTileState();
}

class _CustomMovieTileState extends State<CustomMovieTile> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 100,
        height: 150,
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
                      _quantity--;
                      widget.onQuantityChanged(_quantity); // Llamar al callback con la cantidad actualizada
                    }
                  });
                },
                icon: Icon(Icons.remove),
              ),
              Text('$_quantity'),
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++;
                    widget.onQuantityChanged(_quantity); // Llamar al callback con la cantidad actualizada
                  });
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
