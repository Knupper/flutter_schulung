import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      width: 400,
      height: 400,
      color: Colors.red,
      child: const Center(
        child: Text(
          'Error',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
