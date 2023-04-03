import 'package:flutter/material.dart';

class Game1 extends StatefulWidget {
  const Game1({super.key});

  @override
  State<Game1> createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game 1'),
      ),
      body: const Center(
        child: Text('Game 1'),
      ),
    );
  }
}
