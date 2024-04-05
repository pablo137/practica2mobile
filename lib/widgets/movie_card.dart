import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final Map<String, dynamic> movie;
  final double moviePrice = 20.0;

  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: _isSelected ? Colors.black54 : null,
                  child: Text(
                    widget.movie['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isSelected ? Colors.white : null,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Opacity(
                  opacity: _isSelected ? 0.5 : 1.0,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w200${widget.movie['poster_path']}',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            if (_isSelected)
              Positioned(
                top: 110,
                left: 130,
                child: Transform.rotate(
                  angle: 0, // 45 degrees in radians
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      'Seleccionado',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(8),
                color: _isSelected ? Colors.black54 : null,
                child: Text(
                  '\$${widget.moviePrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _isSelected ? Colors.white : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
