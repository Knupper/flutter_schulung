import 'package:flutter/material.dart';

class AdviceCard extends StatelessWidget {
  const AdviceCard({super.key, required this.advice});

  final String advice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      color: Colors.green,
      child: Center(
        child: Text(
          '"$advice"',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
