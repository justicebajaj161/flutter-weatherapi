import 'package:flutter/material.dart';
import 'package:first_app/styled_text.dart';

const startAlignment = Alignment.topRight;

class GradiantContainer extends StatelessWidget {
  const GradiantContainer({super.key});

  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 209, 1, 1),
          Color.fromARGB(31, 0, 209, 53)
        ], begin: startAlignment, end: Alignment.bottomLeft),
      ),
      child: const Center(
        child: StyledText("hellpo"),
      ),
    );
  }
}
