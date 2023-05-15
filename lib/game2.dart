import 'dart:math';
import 'package:flutter/material.dart';
import 'solo.dart';
import 'endgame.dart';

class Game2 extends StatefulWidget {
  const Game2({super.key});

  @override
  State<Game2> createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 71, 71),
        body: SafeArea(child: ListView()));
  }
}
