
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Text(
          '¡Compra realizada con éxito!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}